import java.util.Stack;

class Solution {
    public double[] getCollisionTimes(int[][] cars) {
        int n = cars.length;
        double[] ans = new double[n];
        Stack<Integer> stack = new Stack<>(); // Stores indices of cars

        // Initialize all collision times to -1.0 (no collision)
        for (int i = 0; i < n; i++) {
            ans[i] = -1.0;
        }

        // Iterate cars from right to left
        for (int i = n - 1; i >= 0; i--) {
            int currentCarPos = cars[i][0];
            int currentCarSpeed = cars[i][1];

            // While stack is not empty, process potential collision targets
            while (!stack.isEmpty()) {
                int j = stack.peek(); // Car j is in front of car i
                int frontCarPos = cars[j][0];
                int frontCarSpeed = cars[j][1];

                // Condition 1: Current car is slower than or equal to the front car.
                // It will never catch up. So, the front car is not relevant for collision with current car.
                // Pop front car, as it's not a candidate for collision with current car.
                if (currentCarSpeed <= frontCarSpeed) {
                    stack.pop();
                } 
                // Condition 2: Current car is faster than the front car. Collision is possible.
                else {
                    double timeToCollide = (double)(frontCarPos - currentCarPos) / (currentCarSpeed - frontCarSpeed);

                    // If the front car (j) has a collision time (ans[j] != -1.0)
                    // AND current car (i) collides with front car (j) AFTER or AT THE SAME TIME
                    // front car (j) collides with its next car (ans[j])
                    // Then, front car (j) will have already merged into a fleet by the time current car (i) reaches it.
                    // So, current car (i) will effectively be chasing the fleet that j is part of.
                    // Thus, j is not the car i will collide with. Pop j.
                    if (ans[j] != -1.0 && timeToCollide >= ans[j]) {
                        stack.pop();
                    } 
                    // Otherwise (ans[j] == -1.0 OR timeToCollide < ans[j]):
                    // Current car (i) collides with front car (j) before j collides with anything else.
                    // So, j is the car i will collide with.
                    // Set collision time for i and break the loop.
                    else {
                        ans[i] = timeToCollide;
                        break;
                    }
                }
            }
            // Push current car onto the stack. It might be a collision target for cars to its left.
            stack.push(i);
        }

        return ans;
    }
}