use std::collections::HashMap;

impl Solution {
    pub fn smallest_sufficient_team(req_skills: Vec<String>, people: Vec<Vec<String>>) -> Vec<i32> {
        let n = req_skills.len();
        let m = people.len();

        let mut skill_id = HashMap::new();
        for (i, skill) in req_skills.iter().enumerate() {
            skill_id.insert(skill.clone(), i);
        }

        let mut masks = vec![0; m];
        for i in 0..m {
            for skill in &people[i] {
                if let Some(&id) = skill_id.get(skill) {
                    masks[i] |= 1 << id;
                }
            }
        }

        let mut dp = vec![Vec::new(); 1 << n];
        dp[0] = vec![];

        for mask in 0..(1 << n) {
            if dp[mask].is_empty() {
                continue;
            }

            for i in 0..m {
                let new_mask = mask | masks[i];

                if new_mask == mask {
                    continue;
                }

                if dp[new_mask].is_empty() || dp[new_mask].len() > dp[mask].len() + 1 {
                    dp[new_mask] = dp[mask].clone();
                    dp[new_mask].push(i as i32);
                }
            }
        }

        dp[(1 << n) - 1].clone()
    }
}