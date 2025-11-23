impl Solution {
    pub fn can_form_original_string(s1: String, s2: String, target: String) -> bool {
        let count1 = s1.chars().fold(std::collections::HashMap::new(), |mut acc, c| {
            *acc.entry(c).or_insert(0) += 1;
            acc
        });
        let count2 = s2.chars().fold(std::collections::HashMap::new(), |mut acc, c| {
            *acc.entry(c).or_insert(0) += 1;
            acc
        });
        let target_count = target.chars().fold(std::collections::HashMap::new(), |mut acc, c| {
            *acc.entry(c).or_insert(0) += 1;
            acc
        });

        for (c, &t_count) in target_count.iter() {
            let s1_count = count1.get(c).unwrap_or(&0);
            let s2_count = count2.get(c).unwrap_or(&0);
            if s1_count + s2_count < t_count {
                return false;
            }
        }
        true
    }
}