impl Solution {

use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn people_who_own_a_unique_good_company(people: Vec<Vec<String>>) -> Vec<i32> {
        let mut company_to_people = HashMap::new();
        let mut result = Vec::new();

        for (i, companies) in people.iter().enumerate() {
            let set = companies.iter().map(|s| s.as_str()).collect::<HashSet<_>>();
            for company in companies {
                company_to_people.entry(company).or_insert_with(HashSet::new).insert(i);
            }
        }

        for (i, companies) in people.iter().enumerate() {
            let set = companies.iter().map(|s| s.as_str()).collect::<HashSet<_>>();
            let is_unique = company_to_people.iter().all(|(_, people_set)| {
                people_set.len() == 1 && people_set.contains(&i)
            });
            if is_unique {
                result.push(i as i32);
            }
        }

        result
    }
}
}