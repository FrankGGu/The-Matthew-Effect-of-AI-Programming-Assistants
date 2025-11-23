impl Solution {
    fn count_set_bits(n: i32) -> i32 {
        n.count_ones() as i32
    }

    pub fn can_sort_array(mut nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n <= 1 {
            return true;
        }

        let mut i = 0;
        while i < n {
            let mut j = i;
            let current_bits = Self::count_set_bits(nums[i]);

            while j < n && Self::count_set_bits(nums[j]) == current_bits {
                j += 1;
            }

            nums[i..j].sort_unstable();

            i = j;
        }

        for k in 0..n - 1 {
            if nums[k] > nums[k + 1] {
                return false;
            }
        }

        true
    }
}