use std::collections::HashMap;

impl Solution {
    pub fn number_of_pairs(skill: Vec<i32>) -> i64 {
        let mut count = 0;
        let mut freq: HashMap<i32, i32> = HashMap::new();

        for &s in &skill {
            *freq.entry(s).or_insert(0) += 1;
        }

        let mut visited: HashMap<i32, bool> = HashMap::new();

        for &s in &skill {
            if *visited.get(&s).unwrap_or(&false) {
                continue;
            }

            if freq.contains_key(&(2 * s)) && *freq.get(&(2 * s)).unwrap() > 0 {
                if 2 * s == s {
                    count += (*freq.get(&(2 * s)).unwrap() as i64) / 2;
                } else {
                    count += std::cmp::min(*freq.get(&s).unwrap(), *freq.get(&(2 * s)).unwrap()) as i64;
                }

                *freq.entry(s).or_insert(0) = 0;
                *freq.entry(2 * s).or_insert(0) = 0;
                visited.insert(s, true);
                visited.insert(2 * s, true);
            }
        }

        let mut freq: HashMap<i32, i32> = HashMap::new();

        for &s in &skill {
            *freq.entry(s).or_insert(0) += 1;
        }

        skill.iter().for_each(|&s| {
             if *visited.get(&s).unwrap_or(&false) {
                *freq.entry(s).or_insert(0) -= 1;
            }
        });

        let mut visited_sum: HashMap<i32, bool> = HashMap::new();

        for i in 0..skill.len() {
            if *visited.get(&skill[i]).unwrap_or(&false) {
                continue;
            }

            if *visited_sum.get(&skill[i]).unwrap_or(&false) {
                continue;
            }

            for j in (i + 1)..skill.len() {
                if *visited.get(&skill[j]).unwrap_or(&false) {
                    continue;
                }

                if skill[i] + skill[j] == 0 {
                    count += 1;
                }
            }
            visited_sum.insert(skill[i], true);
        }

        let mut sum_count = 0;
        for i in 0..skill.len() {
            if *visited.get(&skill[i]).unwrap_or(&false) {
                continue;
            }

            for j in (i + 1)..skill.len() {
                if *visited.get(&skill[j]).unwrap_or(&false) {
                    continue;
                }

                if skill[i] + skill[j] == 0 {
                    sum_count += 1;
                }
            }
        }

        let mut two_count = 0;
        let mut freq: HashMap<i32, i32> = HashMap::new();

        for &s in &skill {
            *freq.entry(s).or_insert(0) += 1;
        }

        let mut visited_two: HashMap<i32, bool> = HashMap::new();
        for &s in &skill {
            if *visited_two.get(&s).unwrap_or(&false) {
                continue;
            }
            for &t in &skill {
                if s + t == 0 {
                    two_count += 1;
                }
            }
            visited_two.insert(s, true);
        }

        let mut total_count = 0;
        for i in 0..skill.len(){
            for j in (i+1)..skill.len() {
                if skill[i] + skill[j] == 0 {
                    total_count += 1;
                }
            }
        }

        let mut freq: HashMap<i32, i32> = HashMap::new();

        for &s in &skill {
            *freq.entry(s).or_insert(0) += 1;
        }

        let mut count_skill = 0;
        for (key, value) in freq.iter() {
            if *key + *key == 0 {
                count_skill += (value * (value - 1)) / 2;
            }
        }
        let mut sum_count_new = 0;

        for i in 0..skill.len() {
            for j in (i + 1)..skill.len() {
                if skill[i] + skill[j] == 0 {
                    sum_count_new +=1;
                }
            }
        }
        sum_count_new as i64
    }
}