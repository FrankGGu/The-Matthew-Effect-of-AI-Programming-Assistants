impl Solution {
    pub fn count_even(num: i32) -> i32 {
        (1..=num)
            .filter(|&x| (x.to_string().chars().map(|c| c.to_digit(10).unwrap()).sum::<u32>() % 2) == 0)
            .count() as i32
    }
}