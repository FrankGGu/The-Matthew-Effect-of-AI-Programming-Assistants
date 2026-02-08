struct Solution;

impl Solution {
    const LESS_THAN_20: [&'static str; 20] = [
        "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
        "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen",
    ];

    const TENS: [&'static str; 10] = [
        "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety",
    ];

    fn helper(n: i32) -> Vec<String> {
        let mut parts = Vec::new();
        if n == 0 {
            return parts;
        }

        if n < 20 {
            parts.push(Self::LESS_THAN_20[n as usize].to_string());
        } else if n < 100 {
            parts.push(Self::TENS[n as usize / 10].to_string());
            parts.extend(Self::helper(n % 10));
        } else { // n < 1000
            parts.push(Self::LESS_THAN_20[n as usize / 100].to_string());
            parts.push("Hundred".to_string());
            parts.extend(Self::helper(n % 100));
        }
        parts
    }

    pub fn number_to_words(mut num: i32) -> String {
        if num == 0 {
            return "Zero".to_string();
        }

        let mut result_parts = Vec::new();

        let billion = num / 1_000_000_000;
        num %= 1_000_000_000;
        if billion > 0 {
            result_parts.extend(Self::helper(billion));
            result_parts.push("Billion".to_string());
        }

        let million = num / 1_000_000;
        num %= 1_000_000;
        if million > 0 {
            result_parts.extend(Self::helper(million));
            result_parts.push("Million".to_string());
        }

        let thousand = num / 1_000;
        num %= 1_000;
        if thousand > 0 {
            result_parts.extend(Self::helper(thousand));
            result_parts.push("Thousand".to_string());
        }

        if num > 0 {
            result_parts.extend(Self::helper(num));
        }

        result_parts.join(" ")
    }
}