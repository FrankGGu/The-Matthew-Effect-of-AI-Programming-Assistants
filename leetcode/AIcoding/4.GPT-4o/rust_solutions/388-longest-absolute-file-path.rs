impl Solution {
    pub fn length_longest_path(input: String) -> i32 {
        let mut max_length = 0;
        let mut path_lengths = vec![0; input.matches('\n').count() + 1];

        for line in input.lines() {
            let depth = line.chars().take_while(|&c| c == '\t').count();
            let name_length = line.trim_start_matches('\t').len();

            if line.contains('.') {
                max_length = max_length.max(path_lengths[depth] + name_length);
            } else {
                path_lengths[depth + 1] = path_lengths[depth] + name_length + 1;
            }
        }

        max_length as i32
    }
}