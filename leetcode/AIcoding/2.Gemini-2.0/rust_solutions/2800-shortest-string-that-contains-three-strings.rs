impl Solution {
    pub fn shortest_superstring(a: String, b: String, c: String) -> String {
        let strs = vec![a, b, c];
        let mut perms = Vec::new();
        let mut used = vec![false; 3];
        let mut current = Vec::new();

        fn permute(
            strs: &Vec<String>,
            used: &mut Vec<bool>,
            current: &mut Vec<usize>,
            perms: &mut Vec<Vec<usize>>,
        ) {
            if current.len() == 3 {
                perms.push(current.clone());
                return;
            }

            for i in 0..3 {
                if !used[i] {
                    used[i] = true;
                    current.push(i);
                    permute(strs, used, current, perms);
                    current.pop();
                    used[i] = false;
                }
            }
        }

        permute(&strs, &mut used, &mut current, &mut perms);

        let mut min_len = usize::MAX;
        let mut result = String::new();

        for perm in perms {
            let mut combined = strs[perm[0]].clone();
            for i in 1..3 {
                let prev = &strs[perm[i - 1]];
                let curr = &strs[perm[i]];
                let overlap = Self::overlap(prev, curr);
                combined.push_str(&curr[overlap..]);
            }

            if combined.len() < min_len {
                min_len = combined.len();
                result = combined;
            }
        }

        result
    }

    fn overlap(s1: &String, s2: &String) -> usize {
        let mut max_overlap = 0;
        for i in 1..=std::cmp::min(s1.len(), s2.len()) {
            if s1[s1.len() - i..] == s2[0..i] {
                max_overlap = i;
            }
        }
        max_overlap
    }
}