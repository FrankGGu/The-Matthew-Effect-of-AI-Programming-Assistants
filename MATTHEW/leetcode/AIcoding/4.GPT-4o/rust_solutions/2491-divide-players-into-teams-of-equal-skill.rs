impl Solution {
    pub fn divide_players(skill: Vec<i32>) -> Vec<Vec<i32>> {
        let total_skill: i32 = skill.iter().sum();
        let n = skill.len() as i32;
        let target_skill = total_skill / (n / 2);
        let mut skill.sort();
        let mut teams = Vec::new();

        for i in 0..n / 2 {
            let first = skill[i as usize];
            let second = skill[(n - 1 - i) as usize];
            if first + second != target_skill {
                return vec![];
            }
            teams.push(vec![first, second]);
        }

        teams
    }
}