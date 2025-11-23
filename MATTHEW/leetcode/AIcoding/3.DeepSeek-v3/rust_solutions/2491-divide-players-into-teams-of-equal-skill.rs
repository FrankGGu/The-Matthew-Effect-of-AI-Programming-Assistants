impl Solution {
    pub fn divide_players(mut skill: Vec<i32>) -> i64 {
        skill.sort();
        let n = skill.len();
        let target = skill[0] + skill[n - 1];
        let mut total_chemistry = 0i64;

        for i in 0..n / 2 {
            let sum = skill[i] + skill[n - 1 - i];
            if sum != target {
                return -1;
            }
            total_chemistry += (skill[i] as i64) * (skill[n - 1 - i] as i64);
        }

        total_chemistry
    }
}