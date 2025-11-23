impl Solution {
    pub fn length_longest_path(input: String) -> i32 {
        let mut max_len = 0;
        let mut path_lens: Vec<i32> = vec![0; 1];

        for line in input.split('\n') {
            let level = line.chars().take_while(|&c| c == '\t').count();
            let name = &line[level..];
            let len = name.len();

            if level + 1 > path_lens.len() {
                path_lens.push(0);
            }

            path_lens[level + 1] = path_lens[level] + len as i32 + 1;

            if name.contains('.') {
                max_len = max_len.max(path_lens[level + 1] - 1);
            }
        }

        max_len
    }
}