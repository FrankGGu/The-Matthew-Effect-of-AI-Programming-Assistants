impl Solution {
    pub fn add_to_array_form(num: Vec<i32>, k: i32) -> Vec<i32> {
        let mut result: Vec<i32> = Vec::new();
        let mut current_k = k;
        let mut i = num.len() as i32 - 1;

        while i >= 0 || current_k > 0 {
            let mut sum = current_k;
            if i >= 0 {
                sum += num[i as usize];
            }

            result.push(sum % 10);
            current_k = sum / 10;
            i -= 1;
        }

        result.reverse();
        result
    }
}