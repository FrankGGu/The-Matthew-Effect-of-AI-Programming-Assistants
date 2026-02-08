impl Solution {
    pub fn number_to_words(num: i32) -> String {
        if num == 0 {
            return "Zero".to_string();
        }

        let below_twenty = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"];
        let below_hundred = ["", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"];

        fn helper(num: i32, below_twenty: &[&str], below_hundred: &[&str]) -> String {
            if num < 20 {
                below_twenty[num as usize].to_string()
            } else if num < 100 {
                let tens = below_hundred[(num / 10) as usize].to_string();
                let ones = below_twenty[(num % 10) as usize].to_string();
                if ones.is_empty() {
                    tens
                } else {
                    format!("{} {}", tens, ones)
                }
            } else if num < 1000 {
                let hundreds = below_twenty[(num / 100) as usize].to_string();
                let remainder = helper(num % 100, below_twenty, below_hundred);
                if remainder.is_empty() {
                    format!("{} Hundred", hundreds)
                } else {
                    format!("{} Hundred {}", hundreds, remainder)
                }
            } else if num < 1000000 {
                let thousands = helper(num / 1000, below_twenty, below_hundred);
                let remainder = helper(num % 1000, below_twenty, below_hundred);
                if remainder.is_empty() {
                    format!("{} Thousand", thousands)
                } else {
                    format!("{} Thousand {}", thousands, remainder)
                }
            } else if num < 1000000000 {
                let millions = helper(num / 1000000, below_twenty, below_hundred);
                let remainder = helper(num % 1000000, below_twenty, below_hundred);
                if remainder.is_empty() {
                    format!("{} Million", millions)
                } else {
                    format!("{} Million {}", millions, remainder)
                }
            } else {
                let billions = helper(num / 1000000000, below_twenty, below_hundred);
                let remainder = helper(num % 1000000000, below_twenty, below_hundred);
                if remainder.is_empty() {
                    format!("{} Billion", billions)
                } else {
                    format!("{} Billion {}", billions, remainder)
                }
            }
        }

        helper(num, &below_twenty, &below_hundred)
    }
}