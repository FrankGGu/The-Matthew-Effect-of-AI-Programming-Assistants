impl Solution {
    pub fn is_robot_bounded(instructions: String) -> bool {
        let mut x = 0;
        let mut y = 0;
        let mut dir = 0; // 0: North, 1: East, 2: South, 3: West
        let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];

        for c in instructions.chars() {
            match c {
                'G' => {
                    x += directions[dir].0;
                    y += directions[dir].1;
                },
                'L' => dir = (dir + 3) % 4,
                'R' => dir = (dir + 1) % 4,
                _ => (),
            }
        }

        (x == 0 && y == 0) || dir != 0
    }
}