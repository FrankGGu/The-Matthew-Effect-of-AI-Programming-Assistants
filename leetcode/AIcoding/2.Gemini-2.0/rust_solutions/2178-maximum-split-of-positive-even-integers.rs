impl Solution {
    pub fn maximum_even_split(final_sum: i64) -> Vec<i64> {
        if final_sum % 2 != 0 {
            return vec![];
        }

        let mut result: Vec<i64> = vec![];
        let mut current_sum: i64 = 0;
        let mut current_num: i64 = 2;

        while current_sum + current_num <= final_sum {
            result.push(current_num);
            current_sum += current_num;
            current_num += 2;
        }

        if current_sum < final_sum {
            let diff = final_sum - current_sum;
            if let Some(last) = result.last_mut() {
                *last += diff;
            }
        }

        result
    }
}