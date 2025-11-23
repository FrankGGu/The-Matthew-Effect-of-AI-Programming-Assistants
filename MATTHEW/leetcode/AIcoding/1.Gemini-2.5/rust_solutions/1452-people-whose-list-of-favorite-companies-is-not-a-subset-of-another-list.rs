use std::collections::HashSet;

impl Solution {
    pub fn people_whose_list_of_favorite_companies_is_not_a_subset_of_another_list(favorite_companies: Vec<Vec<String>>) -> Vec<i32> {
        let n = favorite_companies.len();
        let mut company_sets: Vec<HashSet<String>> = Vec::with_capacity(n);

        for companies in favorite_companies.into_iter() {
            company_sets.push(companies.into_iter().collect());
        }

        let mut result: Vec<i32> = Vec::new();

        for i in 0..n {
            let mut is_subset_of_another = false;
            for j in 0..n {
                if i == j {
                    continue;
                }
                if company_sets[i].is_subset(&company_sets[j]) {
                    is_subset_of_another = true;
                    break;
                }
            }
            if !is_subset_of_another {
                result.push(i as i32);
            }
        }

        result
    }
}