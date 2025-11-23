impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn possibly_equals(s: String, t: String) -> bool {
        fn parse(s: &str) -> Vec<(char, usize)> {
            let mut res = Vec::new();
            let mut i = 0;
            while i < s.len() {
                if s.as_bytes()[i] >= b'0' && s.as_bytes()[i] <= b'9' {
                    let mut j = i;
                    while j < s.len() && s.as_bytes()[j] >= b'0' && s.as_bytes()[j] <= b'9' {
                        j += 1;
                    }
                    let num = s[i..j].parse::<usize>().unwrap();
                    res.push((s.as_bytes()[j], num));
                    i = j + 1;
                } else {
                    res.push((s.as_bytes()[i], 1));
                    i += 1;
                }
            }
            res
        }

        fn dfs(s: &[(&char, usize)], t: &[(&char, usize)], i: usize, j: usize, memo: &mut HashMap<(usize, usize), bool>) -> bool {
            if i == s.len() && j == t.len() {
                return true;
            }
            if i == s.len() || j == t.len() {
                return false;
            }
            if let Some(&res) = memo.get(&(i, j)) {
                return res;
            }

            let (sc, sn) = s[i];
            let (tc, tn) = t[j];

            if sc == tc {
                if dfs(s, t, i + 1, j + 1, memo) {
                    memo.insert((i, j), true);
                    return true;
                }
            }

            if sn > 0 && tn > 0 {
                for k in 1..=sn {
                    if k <= tn && dfs(s, t, i + 1, j + 1, memo) {
                        memo.insert((i, j), true);
                        return true;
                    }
                }
            }

            if sn > 0 {
                for k in 1..=sn {
                    if dfs(s, t, i + 1, j, memo) {
                        memo.insert((i, j), true);
                        return true;
                    }
                }
            }

            if tn > 0 {
                for k in 1..=tn {
                    if dfs(s, t, i, j + 1, memo) {
                        memo.insert((i, j), true);
                        return true;
                    }
                }
            }

            memo.insert((i, j), false);
            false
        }

        let s_parsed = parse(&s);
        let t_parsed = parse(&t);
        let mut memo = HashMap::new();
        dfs(&s_parsed, &t_parsed, 0, 0, &mut memo)
    }
}
}