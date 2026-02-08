class Robot {
    private int width;
    private int height;
    private int perimeter;
    private long total_steps;
    private int x;
    private int y;
    private int dir_idx; // 0: East, 1: North, 2: West, 3: South
    private boolean is_initial_state; // True if total_steps is 0

    private String[] directions = {"East", "North", "West", "South"};

    public Robot(int width, int height) {
        this.width = width;
        this.height = height;
        this.perimeter = 2 * (width - 1) + 2 * (height - 1);
        this.total_steps = 0;
        this.x = 0;
        this.y = 0;
        this.dir_idx = 0; // Starts facing East
        this.is_initial_state = true;
    }

    public void step(int num) {
        total_steps += num;
        is_initial_state = false;
    }

    private void update_current_position_and_direction() {
        if (width == 1 && height == 1) {
            x = 0; y = 0; dir_idx = 0; // Always (0,0) East
            return;
        }

        long effective_steps = total_steps % perimeter;

        if (effective_steps == 0 && !is_initial_state) {
            // If we completed full cycles and landed back at (0,0) after moving,
            // the direction depends on the grid shape.
            x = 0; y = 0;
            if (height == 1) { // Arrived at (0,0) from (1,0) going West
                dir_idx = 2; // West
            } else { // Arrived at (0,0) from (0,1) going South
                dir_idx = 3; // South
            }
            return;
        }

        // If effective_steps == 0 and is_initial_state is true, it means total_steps is 0,
        // so it's (0,0) East, which is handled by the first segment below.

        long steps_passed = effective_steps;
        int W_minus_1 = width - 1;
        int H_minus_1 = height - 1;

        if (steps_passed <= W_minus_1) {
            // East leg: (0,0) to (W-1,0)
            x = (int) steps_passed;
            y = 0;
            dir_idx = 0; // East
        } else if (steps_passed <= W_minus_1 + H_minus_1) {
            // North leg: (W-1,0) to (W-1,H-1)
            steps_passed -= W_minus_1;
            x = W_minus_1;
            y = (int) steps_passed;
            dir_idx = 1; // North
        } else if (steps_passed <= W_minus_1 + H_minus_1 + W_minus_1) {
            // West leg: (W-1,H-1) to (0,H-1)
            steps_passed -= (W_minus_1 + H_minus_1);
            x = (int) (W_minus_1 - steps_passed);
            y = H_minus_1;
            dir_idx = 2; // West
        } else {
            // South leg: (0,H-1) to (0,0)
            steps_passed -= (W_minus_1 + H_minus_1 + W_minus_1);
            x = 0;
            y = (int) (H_minus_1 - steps_passed);
            dir_idx = 3; // South
        }
    }

    public int[] getPos() {
        update_current_position_and_direction();
        return new int[]{x, y};
    }

    public String getDir() {
        update_current_position_and_direction();
        return directions[dir_idx];
    }
}