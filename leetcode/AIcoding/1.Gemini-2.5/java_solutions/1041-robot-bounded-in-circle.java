class Solution {
    public boolean isRobotBounded(String instructions) {
        int x = 0;
        int y = 0;
        int dir = 0; // 0: North, 1: East, 2: South, 3: West

        int[] dx = {0, 1, 0, -1}; // Change in x for N, E, S, W
        int[] dy = {1, 0, -1, 0}; // Change in y for N, E, S, W

        for (char instruction : instructions.toCharArray()) {
            if (instruction == 'G') {
                x += dx[dir];
                y += dy[dir];
            } else if (instruction == 'L') {
                dir = (dir + 3) % 4; // Turn left (N->W, E->N, S->E, W->S)
            } else { // instruction == 'R'
                dir = (dir + 1) % 4; // Turn right (N->E, E->S, S->W, W->N)
            }
        }

        // The robot is bounded if:
        // 1. It returns to the origin (0,0).
        // 2. It does not end up facing North. If it faces a different direction,
        //    subsequent cycles will cause it to rotate and eventually return to the origin.
        return (x == 0 && y == 0) || (dir != 0);
    }
}