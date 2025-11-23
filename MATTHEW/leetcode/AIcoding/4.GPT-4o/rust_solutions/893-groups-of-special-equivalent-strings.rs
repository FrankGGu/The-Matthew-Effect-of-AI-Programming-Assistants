use std::collections::HashSet;

impl Solution {
    pub fn num_special_equiv_groups(a: Vec<String>) -> i32 {
        let mut groups = HashSet::new();

        for s in a {
            let (mut odd, mut even) = (vec![0; 26], vec![0; 26]);
            for (i, c) in s.chars().enumerate() {
                if i % 2 == 0 {
                    even[c as usize - 'a' as usize] += 1;
                } else {
                    odd[c as usize - 'a' as usize] += 1;
                }
            }
            groups.insert((odd, even));
        }

        groups.len() as i32
    }
}