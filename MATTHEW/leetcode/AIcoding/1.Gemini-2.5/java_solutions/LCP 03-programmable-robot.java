import java.util.ArrayList;
import java.util.List;

class Solution {
    public boolean[] robot(String program, int[][] queries) {
        // Step 1: Simulate the robot's movement for one full cycle of the program
        // Store all visited points (x, y) in the first cycle, including (0,0)
        List<int[]> path = new ArrayList<>();
        path.add(new int[]{0, 0}); // Starting point

        int currentX = 0;
        int currentY = 0;

        for (char move : program.toCharArray()) {
            if (move == 'U') {
                currentY++;
            } else if (move == 'D') {
                currentY--;
            } else if (move == 'L') {
                currentX--;
            } else if (move == 'R') {
                currentX++;
            }
            path.add(new int[]{currentX, currentY});
        }

        // The net displacement after one full cycle
        int final_dx = currentX;
        int final_dy = currentY;

        // Step 2: Process each query
        boolean[] results = new boolean[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int targetX = queries[i][0];
            int targetY = queries[i][1];

            boolean found = false;
            // Iterate through each point (x_k, y_k) visited in the first cycle
            for (int[] p : path) {
                int x_k = p[0];
                int y_k = p[1];

                // We need to find an integer m >= 0 such that:
                // targetX = x_k + m * final_dx
                // targetY = y_k + m * final_dy

                // Calculate the required displacement from (x_k, y_k) to (targetX, targetY)
                int diffX = targetX - x_k;
                int diffY = targetY - y_k;

                // Handle cases based on final_dx and final_dy
                if (final_dx == 0 && final_dy == 0) {
                    // If robot doesn't move after a full cycle, it only visits points in the first cycle
                    if (diffX == 0 && diffY == 0) {
                        found = true;
                        break;
                    }
                } else if (final_dx == 0) {
                    // Robot only moves along Y-axis after full cycles
                    // X-coordinate must match (diffX must be 0)
                    // diffY must be a non-negative multiple of final_dy
                    if (diffX == 0 && diffY % final_dy == 0) {
                        int m = diffY / final_dy;
                        if (m >= 0) {
                            found = true;
                            break;
                        }
                    }
                } else if (final_dy == 0) {
                    // Robot only moves along X-axis after full cycles
                    // Y-coordinate must match (diffY must be 0)
                    // diffX must be a non-negative multiple of final_dx
                    if (diffY == 0 && diffX % final_dx == 0) {
                        int m = diffX / final_dx;
                        if (m >= 0) {
                            found = true;
                            break;
                        }
                    }
                } else {
                    // Robot moves along both X and Y axes after full cycles
                    // Check if diffX and diffY are multiples of final_dx and final_dy respectively
                    if (diffX % final_dx == 0 && diffY % final_dy == 0) {
                        int m1 = diffX / final_dx;
                        int m2 = diffY / final_dy;

                        // Check if m values are equal and non-negative
                        if (m1 == m2 && m1 >= 0) {
                            found = true;
                            break;
                        }
                    }
                }
            }
            results[i] = found;
        }

        return results;
    }
}