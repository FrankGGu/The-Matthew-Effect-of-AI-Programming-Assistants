impl Solution {
    pub fn maximum_even_split(final_sum: i32) -> Vec<i32> {
        if final_sum % 2 != 0 {
            return vec![];
        }
        let mut result = Vec::new();
        let mut sum = final_sum;
        let mut current = 2;
        while sum > 0 {
            if sum >= current {
                result.push(current);
                sum -= current;
                current += 2;
            } else {
                result[result.len() - 1] += sum;
                break;
            }
        }
        result
    }
}