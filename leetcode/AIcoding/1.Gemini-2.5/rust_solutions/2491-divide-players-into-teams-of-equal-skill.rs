impl Solution {
    pub fn divide_players(mut skill: Vec<i32>) -> i64 {
        skill.sort_unstable();

        let n = skill.len();
        if n % 2 != 0 {
            return -1;
        }

        let mut total_chemistry: i64 = 0;
        let mut left = 0;
        let mut right = n - 1;

        let expected_sum = skill[left] + skill[right];

        while left < right {
            if skill[left] + skill[right] != expected_sum {
                return -1;
            }
            total_chemistry += (skill[left] as i64) * (skill[right] as i64);
            left += 1;
            right -= 1;
        }

        total_chemistry
    }
}