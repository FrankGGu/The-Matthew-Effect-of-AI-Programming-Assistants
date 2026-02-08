impl Solution {
    pub fn maximize_minimum(nums: Vec<i32>, p: i32) -> i32 {
        let n = nums.len();
        let mut low = 0;
        let mut high = *nums.iter().max().unwrap();

        while low < high {
            let mid = (low + high + 1) / 2;
            let mut count = 0;
            let mut i = 0;

            while i < n {
                if nums[i] >= mid {
                    count += 1;
                    i += 2;
                } else {
                    i += 1;
                }
            }

            if count >= p {
                low = mid;
            } else {
                high = mid - 1;
            }
        }

        low
    }
}