use std::collections::HashSet;

pub fn longest_square_streak(nums: Vec<i32>) -> i32 {
    let mut unique_nums: HashSet<i32> = HashSet::new();
    for &num in &nums {
        unique_nums.insert(num);
    }

    let mut longest_streak = 0;

    for &num in &unique_nums {
        let mut streak = 0;
        let mut current = num;

        while unique_nums.contains(&(current * current)) {
            streak += 1;
            current += 1;
        }

        longest_streak = longest_streak.max(streak);
    }

    if longest_streak < 2 { return 0; }
    longest_streak
}