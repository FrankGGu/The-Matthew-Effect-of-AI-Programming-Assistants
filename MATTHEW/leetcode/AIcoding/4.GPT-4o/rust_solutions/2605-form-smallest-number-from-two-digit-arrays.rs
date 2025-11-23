impl Solution {
    pub fn min_number(arr1: Vec<i32>, arr2: Vec<i32>) -> String {
        let mut common = Vec::new();
        let mut digits = Vec::new();

        for &digit in arr1.iter() {
            if arr2.contains(&digit) {
                common.push(digit);
            }
            digits.push(digit);
        }

        for &digit in arr2.iter() {
            if !arr1.contains(&digit) {
                digits.push(digit);
            }
        }

        if common.is_empty() {
            digits.sort();
            return digits.iter().map(|d| d.to_string()).collect::<String>();
        }

        common.sort();
        let smallest_common = common[0];
        let mut result = vec![smallest_common.to_string()];

        digits.sort();
        for &digit in &digits {
            if digit != smallest_common {
                result.push(digit.to_string());
            }
        }

        result.join("")
    }
}