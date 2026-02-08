impl Solution {
    pub fn number_to_words(num: i32) -> String {
        if num == 0 {
            return "Zero".to_string();
        }
        let units = ["", "Thousand", "Million", "Billion"];
        let mut num = num as i64;
        let mut res = Vec::new();
        let mut i = 0;
        while num > 0 {
            let chunk = num % 1000;
            if chunk != 0 {
                let mut chunk_str = Self::convert_less_than_thousand(chunk as i32);
                if i > 0 {
                    chunk_str.push_str(" ");
                    chunk_str.push_str(units[i as usize]);
                }
                res.push(chunk_str);
            }
            num /= 1000;
            i += 1;
        }
        res.reverse();
        res.join(" ")
    }

    fn convert_less_than_thousand(num: i32) -> String {
        let below_20 = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"];
        let tens = ["", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"];
        let mut num = num;
        let mut res = Vec::new();
        if num >= 100 {
            res.push(below_20[(num / 100) as usize].to_string());
            res.push("Hundred".to_string());
            num %= 100;
        }
        if num >= 20 {
            res.push(tens[(num / 10) as usize].to_string());
            num %= 10;
        }
        if num > 0 {
            res.push(below_20[num as usize].to_string());
        }
        res.join(" ")
    }
}