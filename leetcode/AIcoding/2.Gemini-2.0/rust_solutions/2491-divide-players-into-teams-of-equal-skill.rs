impl Solution {
    pub fn divide_players(mut skill: Vec<i32>) -> i64 {
        skill.sort();
        let n = skill.len();
        let mut sum = 0;
        let target = skill[0] + skill[n - 1];
        for i in 0..n / 2 {
            if skill[i] + skill[n - 1 - i] != target {
                return -1;
            }
            sum += (skill[i] * skill[n - 1 - i]) as i64;
        }
        sum
    }
}