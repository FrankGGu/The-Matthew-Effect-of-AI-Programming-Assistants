impl Solution {
    pub fn is_robot_bounded(instructions: String) -> bool {
        let mut x = 0;
        let mut y = 0;
        // 0: North, 1: East, 2: South, 3: West
        let mut direction = 0;

        // dx, dy for each direction: (North, East, South, West)
        let dx = [0, 1, 0, -1];
        let dy = [1, 0, -1, 0];

        for instruction in instructions.chars() {
            match instruction {
                'G' => {
                    x += dx[direction];
                    y += dy[direction];
                }
                'L' => {
                    direction = (direction + 3) % 4; // Turn left (0->3, 1->0, 2->1, 3->2)
                }
                'R' => {
                    direction = (direction + 1) % 4; // Turn right (0->1, 1->2, 2->3, 3->0)
                }
                _ => {} // Should not happen based on problem description
            }
        }

        // The robot is bounded if:
        // 1. It returns to the origin (0,0) after one cycle.
        // 2. It does not return to the origin but changes its direction (i.e., not facing North) after one cycle.
        //    If it changes direction, it will eventually return to the origin after at most 4 cycles.
        x == 0 && y == 0 || direction != 0
    }
}