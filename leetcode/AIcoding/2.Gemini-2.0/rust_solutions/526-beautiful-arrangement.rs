impl Solution {
    pub fn count_arrangement(n: i32) -> i32 {
        let mut nums: Vec<i32> = (1..=n).collect();
        let mut count = 0;

        fn permute(nums: &mut Vec<i32>, l: usize, count: &mut i32) {
            if l == nums.len() {
                let mut valid = true;
                for i in 0..nums.len() {
                    if nums[i] % (i as i32 + 1) != 0 && (i as i32 + 1) % nums[i] != 0 {
                        valid = false;
                        break;
                    }
                }
                if valid {
                    *count += 1;
                }
                return;
            }

            for i in l..nums.len() {
                nums.swap(l, i);
                permute(nums, l + 1, count);
                nums.swap(l, i);
            }
        }

        permute(&mut nums, 0, &mut count);
        count
    }
}