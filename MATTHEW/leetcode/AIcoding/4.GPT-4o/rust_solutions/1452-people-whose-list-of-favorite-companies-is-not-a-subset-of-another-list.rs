use std::collections::{HashSet, HashMap};

pub fn people_indexes(favorite_companies: Vec<Vec<String>>) -> Vec<i32> {
    let mut company_map: HashMap<String, HashSet<usize>> = HashMap::new();
    let mut result = vec![];

    for (i, companies) in favorite_companies.iter().enumerate() {
        let set: HashSet<_> = companies.iter().cloned().collect();
        let mut is_subset = false;

        for company in &set {
            if let Some(indices) = company_map.get(company) {
                for &index in indices {
                    if set.is_subset(&favorite_companies[index].iter().cloned().collect()) {
                        is_subset = true;
                        break;
                    }
                }
            }
            if is_subset {
                break;
            }
        }

        if !is_subset {
            result.push(i as i32);
        }

        for company in set {
            company_map.entry(company).or_insert_with(HashSet::new).insert(i);
        }
    }

    result
}