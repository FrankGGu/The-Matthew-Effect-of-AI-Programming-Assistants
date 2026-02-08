struct Solution;

impl Solution {
    pub fn maximum_even_split(final_sum: i64) -> Vec<i64> {
        if final_sum % 2 != 0 {
            return vec![];
        }

        let mut result: Vec<i64> = Vec::new();
        let mut current_even_num = 2;
        let mut remaining_sum = final_sum;

        while remaining_sum >= current_even_num {
            result.push(current_even_num);
            remaining_sum -= current_even_num;
            current_even_num += 2;
        }

        if remaining_sum > 0 {
            if let Some(last_element) = result.last_mut() {
                *last_element += remaining_sum;
            }
        }

        result
    }
}