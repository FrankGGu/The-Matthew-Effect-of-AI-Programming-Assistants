impl Solution {
    pub fn number_to_words(num: i32) -> String {
        if num == 0 {
            return "Zero".to_string();
        }

        let below_20 = vec![
            "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine",
            "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen",
            "Seventeen", "Eighteen", "Nineteen",
        ];
        let below_100 = vec!["", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"];
        let thousands = vec!["", "Thousand", "Million", "Billion"];

        fn helper(num: i32, below_20: &Vec<&str>, below_100: &Vec<&str>) -> String {
            if num == 0 {
                return "".to_string();
            } else if num < 20 {
                return below_20[num as usize].to_string();
            } else if num < 100 {
                return format!("{}{}", below_100[(num / 10) as usize], helper(num % 10, below_20, below_100)).trim().to_string();
            } else {
                return format!("{} Hundred {}", below_20[(num / 100) as usize], helper(num % 100, below_20, below_100)).trim().to_string();
            }
        }

        let mut res = String::new();
        let mut num = num;
        let mut i = 0;

        while num > 0 {
            if num % 1000 != 0 {
                res = format!("{} {} ", helper(num % 1000, &below_20, &below_100), thousands[i]) + &res;
            }
            num /= 1000;
            i += 1;
        }

        res.trim().to_string()
    }
}