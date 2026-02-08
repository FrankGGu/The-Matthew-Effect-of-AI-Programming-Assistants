impl Solution {
    pub fn people_whose_list_of_favorite_companies_is_not_a_subset_of_another_list(
        favorite_companies: Vec<Vec<String>>,
    ) -> Vec<i32> {
        let n = favorite_companies.len();
        let mut ans = Vec::new();
        for i in 0..n {
            let mut is_subset = false;
            for j in 0..n {
                if i == j {
                    continue;
                }
                if Solution::is_subset(&favorite_companies[i], &favorite_companies[j]) {
                    is_subset = true;
                    break;
                }
            }
            if !is_subset {
                ans.push(i as i32);
            }
        }
        ans.sort();
        ans
    }

    fn is_subset(list1: &Vec<String>, list2: &Vec<String>) -> bool {
        if list1.len() > list2.len() {
            return false;
        }
        let set2: std::collections::HashSet<_> = list2.iter().collect();
        for item in list1 {
            if !set2.contains(item) {
                return false;
            }
        }
        true
    }
}