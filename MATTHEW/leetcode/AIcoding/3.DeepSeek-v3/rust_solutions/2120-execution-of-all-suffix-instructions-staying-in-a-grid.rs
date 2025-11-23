impl Solution {
    pub fn execute_instructions(n: i32, start_pos: Vec<i32>, s: String) -> Vec<i32> {
        let s_chars: Vec<char> = s.chars().collect();
        let m = s_chars.len();
        let mut res = vec![0; m];

        for i in 0..m {
            let mut x = start_pos[0];
            let mut y = start_pos[1];
            let mut count = 0;

            for j in i..m {
                match s_chars[j] {
                    'L' => y -= 1,
                    'R' => y += 1,
                    'U' => x -= 1,
                    'D' => x += 1,
                    _ => (),
                }

                if x < 0 || x >= n || y < 0 || y >= n {
                    break;
                }
                count += 1;
            }
            res[i] = count;
        }

        res
    }
}