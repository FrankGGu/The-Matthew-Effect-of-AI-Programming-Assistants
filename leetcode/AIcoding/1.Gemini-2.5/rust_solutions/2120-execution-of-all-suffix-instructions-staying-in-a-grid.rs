impl Solution {
    pub fn execute_instructions(n: i32, start_pos: Vec<i32>, s: String) -> Vec<i32> {
        let mut results = Vec::new();
        let instructions_chars: Vec<char> = s.chars().collect();
        let num_instructions = instructions_chars.len();

        for i in 0..num_instructions {
            let mut current_r = start_pos[0];
            let mut current_c = start_pos[1];
            let mut count = 0;

            for j in i..num_instructions {
                let instruction = instructions_chars[j];

                match instruction {
                    'L' => current_c -= 1,
                    'R' => current_c += 1,
                    'U' => current_r -= 1,
                    'D' => current_r += 1,
                    _ => {} // Should not happen based on problem constraints
                }

                if current_r < 0 || current_r >= n || current_c < 0 || current_c >= n {
                    break;
                } else {
                    count += 1;
                }
            }
            results.push(count);
        }

        results
    }
}