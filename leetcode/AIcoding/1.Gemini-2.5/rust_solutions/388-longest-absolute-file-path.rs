struct Solution;

impl Solution {
    pub fn length_longest_path(input: String) -> i32 {
        let mut max_len = 0;
        let mut path_lengths: Vec<usize> = Vec::new();

        for line in input.lines() {
            let mut depth = 0;
            for c in line.chars() {
                if c == '\t' {
                    depth += 1;
                } else {
                    break;
                }
            }

            let name = &line[depth..];
            let name_len = name.len();

            path_lengths.truncate(depth);

            let current_path_len = if depth == 0 {
                name_len
            } else {
                path_lengths[depth - 1] + 1 + name_len
            };

            path_lengths.push(current_path_len);

            if name.contains('.') {
                max_len = max_len.max(current_path_len);
            }
        }

        max_len as i32
    }
}