impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn minimum_techniques_to_learn(people: Vec<Vec<String>>, target_skills: Vec<String>) -> i32 {
        let mut skill_to_people = HashMap::new();
        for (i, skills) in people.iter().enumerate() {
            for skill in skills {
                skill_to_people.entry(skill).or_insert_with(HashSet::new).insert(i);
            }
        }

        let mut required_skills = HashSet::new();
        for skill in &target_skills {
            required_skills.insert(skill);
        }

        let mut learned_skills = HashSet::new();
        let mut people_teaching = HashSet::new();
        let mut people_teaching_count = 0;

        while learned_skills.len() < target_skills.len() {
            let mut best_skill = None;
            let mut best_people = HashSet::new();

            for skill in &required_skills {
                if !learned_skills.contains(skill) {
                    let people_with_skill = skill_to_people.get(skill).unwrap_or(&HashSet::new());
                    let mut count = 0;
                    let mut candidates = HashSet::new();

                    for person in people_with_skill {
                        if !people_teaching.contains(person) {
                            count += 1;
                            candidates.insert(*person);
                        }
                    }

                    if count > best_people.len() {
                        best_skill = Some(skill);
                        best_people = candidates;
                    }
                }
            }

            if best_skill.is_none() {
                return -1;
            }

            for person in &best_people {
                people_teaching.insert(*person);
            }

            for skill in best_skill.as_ref().unwrap() {
                learned_skills.insert(skill);
            }

            people_teaching_count += 1;
        }

        people_teaching_count
    }
}
}