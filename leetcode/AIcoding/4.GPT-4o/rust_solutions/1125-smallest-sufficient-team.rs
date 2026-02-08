use std::collections::{HashMap, HashSet};

pub fn smallest_sufficient_team(req_skills: Vec<String>, people: Vec<Vec<String>>) -> Vec<i32> {
    let skill_index: HashMap<_, _> = req_skills.into_iter().enumerate().map(|(i, skill)| (skill, i)).collect();
    let mut dp = vec![HashSet::new(); 1 << skill_index.len()];
    let mut team = vec![vec![]; 1 << skill_index.len()];

    for (i, person) in people.iter().enumerate() {
        let mut skill_mask = 0;
        for skill in person {
            if let Some(&index) = skill_index.get(skill) {
                skill_mask |= 1 << index;
            }
        }

        for j in (0..dp.len()).rev() {
            if dp[j].len() > 0 || j == 0 {
                let new_mask = j | skill_mask;
                if dp[new_mask].len() < dp[j].len() + 1 || dp[new_mask].is_empty() {
                    dp[new_mask] = dp[j].clone();
                    dp[new_mask].insert(i);
                    team[new_mask] = team[j].clone();
                    team[new_mask].push(i as i32);
                }
            }
        }
    }

    team[dp.len() - 1].clone()
}