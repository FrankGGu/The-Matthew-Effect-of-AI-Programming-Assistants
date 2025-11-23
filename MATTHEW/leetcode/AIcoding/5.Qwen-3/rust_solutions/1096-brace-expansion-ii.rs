impl Solution {

use std::collections::HashSet;

fn expand(s: String) -> Vec<String> {
    fn backtrack(
        s: &str,
        i: usize,
        res: &mut Vec<String>,
        curr: &mut String,
        groups: &mut Vec<HashSet<char>>,
    ) {
        if i == s.len() {
            res.push(curr.clone());
            return;
        }

        let mut j = i;
        while j < s.len() && s[j] != ',' && s[j] != '}' {
            j += 1;
        }

        if s[i] == '{' {
            let mut group = HashSet::new();
            let mut k = i + 1;
            while k < s.len() && s[k] != '}' {
                if s[k] != ',' {
                    group.insert(s[k]);
                }
                k += 1;
            }
            groups.push(group);
            for c in groups.last().unwrap().iter() {
                curr.push(*c);
                backtrack(s, k + 1, res, curr, groups);
                curr.pop();
            }
            groups.pop();
        } else {
            curr.push(s[i]);
            backtrack(s, i + 1, res, curr, groups);
            curr.pop();
        }
    }

    let mut res = Vec::new();
    let mut curr = String::new();
    let mut groups = Vec::new();
    backtrack(&s, 0, &mut res, &mut curr, &mut groups);
    res.sort();
    res
}

pub fn brace_expansion_ii(s: String) -> Vec<String> {
    expand(s)
}
}