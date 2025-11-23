impl Solution {
    pub fn smallest_sufficient_team(req_skills: Vec<String>, people: Vec<Vec<String>>) -> Vec<i32> {
        use std::collections::HashMap;

        let n = req_skills.len();
        let skill_map: HashMap<_, _> = req_skills.into_iter().enumerate()
            .map(|(i, s)| (s, i))
            .collect();

        let people_bits: Vec<u16> = people.into_iter()
            .map(|skills| {
                let mut mask = 0;
                for skill in skills {
                    if let Some(&i) = skill_map.get(&skill) {
                        mask |= 1 << i;
                    }
                }
                mask
            })
            .collect();

        let target = (1 << n) - 1;
        let mut dp = vec![None; target + 1];
        dp[0] = Some(vec![]);

        for (i, &mask) in people_bits.iter().enumerate() {
            if mask == 0 {
                continue;
            }
            for prev_mask in 0..=target {
                if let Some(prev_team) = &dp[prev_mask] {
                    let new_mask = prev_mask | mask;
                    if dp[new_mask].is_none() || prev_team.len() + 1 < dp[new_mask].as_ref().unwrap().len() {
                        let mut new_team = prev_team.clone();
                        new_team.push(i as i32);
                        dp[new_mask] = Some(new_team);
                    }
                }
            }
        }

        dp[target].unwrap_or_default()
    }
}