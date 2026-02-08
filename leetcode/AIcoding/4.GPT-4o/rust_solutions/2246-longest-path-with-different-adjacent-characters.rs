impl Solution {
    pub fn longest_path(parent: Vec<i32>, s: String) -> i32 {
        let n = parent.len();
        let mut tree = vec![Vec::new(); n];
        for (i, &p) in parent.iter().enumerate() {
            if p != -1 {
                tree[p as usize].push(i);
            }
        }
        let mut max_length = 1;

        fn dfs(node: usize, tree: &Vec<Vec<usize>>, s: &Vec<char>, max_length: &mut i32) -> i32 {
            let mut longest = 0;
            let mut second_longest = 0;
            for &child in &tree[node] {
                let len = dfs(child, tree, s, max_length);
                if s[child] != s[node] {
                    if len > longest {
                        second_longest = longest;
                        longest = len;
                    } else if len > second_longest {
                        second_longest = len;
                    }
                }
            }
            *max_length = (*max_length).max(longest + second_longest + 1);
            longest + 1
        }

        let s_chars: Vec<char> = s.chars().collect();
        dfs(0, &tree, &s_chars, &mut max_length);
        max_length
    }
}