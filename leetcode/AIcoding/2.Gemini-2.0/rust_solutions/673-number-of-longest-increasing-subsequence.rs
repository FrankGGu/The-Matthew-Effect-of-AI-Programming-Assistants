impl Solution {
    pub fn find_number_of_lis(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }

        let mut lengths = vec![1; n];
        let mut counts = vec![1; n];

        for i in 1..n {
            for j in 0..i {
                if nums[i] > nums[j] {
                    if lengths[j] + 1 > lengths[i] {
                        lengths[i] = lengths[j] + 1;
                        counts[i] = counts[j];
                    } else if lengths[j] + 1 == lengths[i] {
                        counts[i] += counts[j];
                    }
                }
            }
        }

        let mut max_len = 0;
        for &len in &lengths {
            max_len = max_len.max(len);
        }

        let mut ans = 0;
        for i in 0..n {
            if lengths[i] == max_len {
                ans += counts[i];
            }
        }

        ans
    }
}