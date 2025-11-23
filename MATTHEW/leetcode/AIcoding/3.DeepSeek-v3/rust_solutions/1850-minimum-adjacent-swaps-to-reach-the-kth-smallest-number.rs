impl Solution {
    pub fn get_min_swaps(num: String, k: i32) -> i32 {
        let mut nums: Vec<char> = num.chars().collect();
        let mut original = nums.clone();
        for _ in 0..k {
            Self::next_permutation(&mut nums);
        }
        let mut res = 0;
        for i in 0..nums.len() {
            if original[i] != nums[i] {
                let mut j = i + 1;
                while j < nums.len() && original[j] != nums[i] {
                    j += 1;
                }
                res += (j - i) as i32;
                original.remove(j);
                original.insert(i, nums[i]);
            }
        }
        res
    }

    fn next_permutation(nums: &mut Vec<char>) {
        let n = nums.len();
        let mut i = n as i32 - 2;
        while i >= 0 && nums[i as usize] >= nums[i as usize + 1] {
            i -= 1;
        }
        if i >= 0 {
            let mut j = n as i32 - 1;
            while j >= 0 && nums[j as usize] <= nums[i as usize] {
                j -= 1;
            }
            nums.swap(i as usize, j as usize);
        }
        let mut left = (i + 1) as usize;
        let mut right = n - 1;
        while left < right {
            nums.swap(left, right);
            left += 1;
            right -= 1;
        }
    }
}