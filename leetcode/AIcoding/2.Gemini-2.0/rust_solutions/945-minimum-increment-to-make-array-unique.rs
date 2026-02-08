impl Solution {
    pub fn min_increment_for_unique(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let mut moves = 0;
        let mut taken = 0;

        for i in 0..nums.len() {
            if i > 0 && nums[i] <= nums[i - 1] {
                taken = std::cmp::max(taken, nums[i - 1] + 1);
                moves += taken - nums[i];
                nums[i] = taken;
                taken += 1;
            } else {
                taken = std::cmp::max(taken, nums[i] + 1);
            }
        }

        moves
    }
}