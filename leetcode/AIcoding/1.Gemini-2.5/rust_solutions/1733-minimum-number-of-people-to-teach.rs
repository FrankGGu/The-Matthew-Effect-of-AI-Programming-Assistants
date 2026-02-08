use std::collections::HashSet;
use std::cmp::max;

impl Solution {
    pub fn minimum_language_to_teach(n: i32, languages: Vec<Vec<i32>>, friendships: Vec<Vec<i32>>) -> i32 {
        let n_usize = n as usize;

        let mut person_languages: Vec<HashSet<i32>> = Vec::with_capacity(n_usize);
        for i in 0..n_usize {
            let mut set = HashSet::new();
            for &lang in &languages[i] {
                set.insert(lang);
            }
            person_languages.push(set);
        }

        let mut involved_people_set: HashSet<usize> = HashSet::new();

        for friendship in friendships {
            let p1_idx = (friendship[0] - 1) as usize;
            let p2_idx = (friendship[1] - 1) as usize;

            let mut can_communicate = false;
            for &lang_p1 in &person_languages[p1_idx] {
                if person_languages[p2_idx].contains(&lang_p1) {
                    can_communicate = true;
                    break;
                }
            }

            if !can_communicate {
                involved_people_set.insert(p1_idx);
                involved_people_set.insert(p2_idx);
            }
        }

        if involved_people_set.is_empty() {
            return 0;
        }

        let mut max_speakers_of_a_language = 0;

        for lang_to_teach in 1..=50 {
            let mut current_speakers = 0;
            for &person_idx in &involved_people_set {
                if person_languages[person_idx].contains(&lang_to_teach) {
                    current_speakers += 1;
                }
            }
            max_speakers_of_a_language = max(max_speakers_of_a_language, current_speakers);
        }

        (involved_people_set.len() - max_speakers_of_a_language) as i32
    }
}