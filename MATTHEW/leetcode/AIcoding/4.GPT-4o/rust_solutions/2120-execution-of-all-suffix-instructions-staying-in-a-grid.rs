pub fn execute_instructions(n: i32, start_pos: Vec<i32>, s: String) -> Vec<i32> {
    let mut result = vec![0; s.len()];
    let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];

    for i in 0..s.len() {
        let (mut x, mut y) = (start_pos[0], start_pos[1]);
        let mut count = 0;

        for j in i..s.len() {
            match s.chars().nth(j).unwrap() {
                'R' => {
                    x += 1;
                },
                'L' => {
                    x -= 1;
                },
                'D' => {
                    y += 1;
                },
                'U' => {
                    y -= 1;
                },
                _ => {}
            }

            if x < 0 || x >= n || y < 0 || y >= n {
                break;
            }
            count += 1;
        }
        result[i] = count;
    }

    result
}