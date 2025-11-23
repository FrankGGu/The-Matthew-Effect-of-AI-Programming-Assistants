impl Solution {
    pub fn sum_imbalance_numbers(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut ans = 0;

        for i in 0..n {
            for j in i..n {
                let mut sub_array: Vec<i32> = nums[i..=j].to_vec();
                sub_array.sort();
                sub_array.dedup();

                let mut imbalance = 0;
                for k in 1..sub_array.len() {
                    if sub_array[k] - sub_array[k - 1] > 1 {
                        imbalance += 1;
                    }
                }
                ans += imbalance;
            }
        }

        ans
    }
}