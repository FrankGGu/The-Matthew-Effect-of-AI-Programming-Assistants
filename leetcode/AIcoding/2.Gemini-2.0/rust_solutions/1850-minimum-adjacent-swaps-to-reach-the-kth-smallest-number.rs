impl Solution {
    pub fn get_min_swaps(num: String, k: i32) -> i32 {
        let mut nums: Vec<char> = num.chars().collect();
        let mut original: Vec<char> = nums.clone();

        for _ in 0..k {
            let mut i = nums.len() - 2;
            while i >= 0 && nums[i] >= nums[i + 1] {
                i -= 1;
            }

            let mut j = nums.len() - 1;
            while nums[j] <= nums[i] {
                j -= 1;
            }

            nums.swap(i, j);

            let mut l = i + 1;
            let mut r = nums.len() - 1;
            while l < r {
                nums.swap(l, r);
                l += 1;
                r -= 1;
            }
            if i == -1 {
                break;
            }
        }

        let mut swaps = 0;
        for i in 0..original.len() {
            if original[i] != nums[i] {
                let mut j = i + 1;
                while original[j] != nums[i] {
                    j += 1;
                }
                for l in (i..j).rev() {
                    original.swap(l, l + 1);
                    swaps += 1;
                }
            }
        }

        swaps
    }
}