impl Solution {
    pub fn recover_array(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();

        for i in 1..=n / 2 {
            if (nums[i] - nums[0]) % 2 == 0 {
                let k = (nums[i] - nums[0]) / 2;
                let mut possible = Vec::new();
                let mut used = vec![false; n];
                let mut j = 0;
                for l in 0..n {
                    if used[l] {
                        continue;
                    }
                    while j < n && (used[j] || nums[j] < nums[l] + 2 * k) {
                        j += 1;
                    }
                    if j == n {
                        possible.clear();
                        break;
                    }
                    if nums[j] != nums[l] + 2 * k {
                        possible.clear();
                        break;
                    }

                    possible.push(nums[l] + k);
                    used[l] = true;
                    used[j] = true;
                    j += 1;
                }

                if possible.len() == n / 2 {
                    return possible;
                }
            }
        }

        Vec::new()
    }
}