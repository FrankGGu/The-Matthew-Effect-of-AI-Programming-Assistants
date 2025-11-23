impl Solution {
    pub fn max_teams(skills: Vec<i32>) -> i32 {
        let n = skills.len();
        let mut teams = 0;
        let mut total_members = 0;

        while total_members + teams + 1 <= n {
            teams += 1;
            total_members += teams;
        }

        teams
    }
}