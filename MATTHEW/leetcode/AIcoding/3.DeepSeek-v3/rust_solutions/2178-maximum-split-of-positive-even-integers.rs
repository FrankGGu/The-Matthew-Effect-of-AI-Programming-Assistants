impl Solution {
    pub fn maximum_even_split(final_sum: i64) -> Vec<i64> {
        if final_sum % 2 != 0 {
            return vec![];
        }
        let mut res = Vec::new();
        let mut sum = 0;
        let mut num = 2;
        while sum + num <= final_sum {
            res.push(num);
            sum += num;
            num += 2;
        }
        if sum < final_sum {
            if let Some(last) = res.last_mut() {
                *last += final_sum - sum;
            }
        }
        res
    }
}