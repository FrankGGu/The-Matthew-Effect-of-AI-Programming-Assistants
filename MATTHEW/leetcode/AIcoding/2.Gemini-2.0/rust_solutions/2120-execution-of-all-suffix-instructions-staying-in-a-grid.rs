impl Solution {
    pub fn execute_instructions(n: i32, start_pos: Vec<i32>, s: String) -> Vec<i32> {
        let mut result = Vec::new();
        let instructions: Vec<char> = s.chars().collect();

        for i in 0..instructions.len() {
            let mut x = start_pos[0];
            let mut y = start_pos[1];
            let mut count = 0;

            for j in i..instructions.len() {
                match instructions[j] {
                    'R' => y += 1,
                    'L' => y -= 1,
                    'U' => x -= 1,
                    'D' => x += 1,
                    _ => {}
                }

                if x < 0 || x >= n || y < 0 || y >= n {
                    break;
                }

                count += 1;
            }

            result.push(count);
        }

        result
    }
}