pub fn is_solvable(words: Vec<String>, result: String) -> bool {
    use std::collections::HashSet;

    fn dfs(
        words: &Vec<String>,
        result: &String,
        index: usize,
        carry: i32,
        mapping: &mut [i32; 26],
        used: &mut HashSet<i32>,
    ) -> bool {
        if index == result.len() {
            return carry == 0;
        }

        let mut sum = carry;
        for word in words.iter() {
            if index < word.len() {
                let ch = word[word.len() - 1 - index] as usize - 'a' as usize;
                sum += mapping[ch];
            }
        }

        let ch_res = result[result.len() - 1 - index] as usize - 'a' as usize;
        let digit = sum % 10;

        if mapping[ch_res] == -1 {
            for d in 0..10 {
                if d != 0 || index < result.len() - 1 {
                    if !used.insert(d) {
                        continue;
                    }
                    mapping[ch_res] = d;
                    if dfs(words, result, index + 1, sum / 10, mapping, used) {
                        return true;
                    }
                    mapping[ch_res] = -1;
                    used.remove(&d);
                }
            }
            used.remove(&0);
        } else if mapping[ch_res] != digit {
            return false;
        }

        dfs(words, result, index + 1, sum / 10, mapping, used)
    }

    let mut mapping = [-1; 26];
    let mut used = HashSet::new();
    dfs(&words, &result, 0, 0, &mut mapping, &mut used)
}