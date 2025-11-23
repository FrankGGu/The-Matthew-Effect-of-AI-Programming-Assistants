impl Solution {
    pub fn largest_perimeter(mut nums: Vec<i32>) -> i64 {
        nums.sort_unstable();

        let m = nums.len();
        if m < 3 {
            return -1;
        }

        let mut current_sum: i64 = nums.iter().map(|&x| x as i64).sum();

        for i in (2..m).rev() {
            let largest_side = nums[i] as i64;
            let sum_of_other_sides = current_sum - largest_side;

            if sum_of_other_sides > largest_side {
                return current_sum;
            } else {
                current_sum = sum_of_other_sides;
            }
        }

        -1
    }
}