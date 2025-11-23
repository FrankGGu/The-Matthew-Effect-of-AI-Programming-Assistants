int findTheChild(int n, int k) {
    if (n == 1) {
        return 0;
    }

    // The ball moves from 0 to n-1 and then from n-1 to 0, completing a cycle.
    // The length of one full cycle (e.g., 0 -> n-1 -> 0) is 2 * (n - 1) seconds.
    int cycle_length = 2 * (n - 1);

    // Find the effective number of seconds within one cycle.
    int effective_k = k % cycle_length;

    int current_child = 0;
    int direction = 1; // 1 for moving towards n-1 (increasing index), -1 for moving towards 0 (decreasing index)

    // Simulate the ball's movement for the effective_k seconds.
    for (int i = 0; i < effective_k; ++i) {
        current_child += direction;

        // Check if the ball reached an end and needs to change direction.
        if (current_child == n - 1) {
            direction = -1; // Change direction to move towards 0
        } else if (current_child == 0) {
            direction = 1; // Change direction to move towards n-1
        }
    }

    return current_child;
}