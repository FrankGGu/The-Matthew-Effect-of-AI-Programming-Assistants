use std::collections::HashMap;

impl Solution {
    pub fn smallest_sufficient_team(req_skills: Vec<String>, people: Vec<Vec<String>>) -> Vec<i32> {
        let n_skills = req_skills.len();
        let n_people = people.len();

        let mut skill_to_idx: HashMap<String, usize> = HashMap::new();
        for (i, skill) in req_skills.into_iter().enumerate() {
            skill_to_idx.insert(skill, i);
        }

        let mut people_skill_masks: Vec<u16> = Vec::with_capacity(n_people);
        for person_skills_list in people.into_iter() {
            let mut skill_mask = 0u16;
            for skill in person_skills_list {
                if let Some(&idx) = skill_to_idx.get(&skill) {
                    skill_mask |= 1 << idx;
                }
            }
            people_skill_masks.push(skill_mask);
        }

        let mut dp: Vec<u64> = vec![u64::MAX; 1 << n_skills];

        dp[0] = 0; // Base case: 0 skills require 0 people (empty team).

        // Iterate through all possible skill combinations (masks)
        for skill_mask in 0..(1 << n_skills) {
            // If no team has been found for this skill_mask yet, we cannot build upon it.
            if dp[skill_mask] == u64::MAX {
                continue;
            }

            // Try adding each person to the team for `skill_mask`
            for p_idx in 0..n_people {
                let person_skills = people_skill_masks[p_idx];
                let person_team_bit = 1u64 << p_idx;

                // Calculate the new skill mask if this person is added
                let new_skill_mask = skill_mask | person_skills;
                // Calculate the new team mask if this person is added
                let new_team_mask = dp[skill_mask] | person_team_bit;

                // If the new team is smaller (fewer people) than the current best team for new_skill_mask
                // (or if new_skill_mask hasn't been reached yet, dp[new_skill_mask] is u64::MAX,
                // which has 64 ones, so any valid team will be smaller)
                if new_team_mask.count_ones() < dp[new_skill_mask].count_ones() {
                    dp[new_skill_mask] = new_team_mask;
                }
            }
        }

        // The final answer is the team mask for all required skills.
        let final_team_mask = dp[(1 << n_skills) - 1];

        // Convert the team bitmask back to a Vec<i32> of person indices.
        let mut result_team: Vec<i32> = Vec::new();
        for i in 0..n_people {
            if (final_team_mask >> i) & 1 == 1 {
                result_team.push(i as i32);
            }
        }

        result_team
    }
}