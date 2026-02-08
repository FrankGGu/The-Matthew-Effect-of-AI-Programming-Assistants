import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public int[] asteroidCollision(int[] asteroids) {
        Deque<Integer> stack = new ArrayDeque<>();

        for (int asteroid : asteroids) {
            int currentAsteroid = asteroid;
            while (!stack.isEmpty() && currentAsteroid < 0 && stack.peekLast() > 0) {
                // Collision is possible: current is left-moving, stack top is right-moving
                int topAsteroid = stack.peekLast();
                if (topAsteroid < Math.abs(currentAsteroid)) {
                    // Stack top explodes, current asteroid continues
                    stack.removeLast();
                } else if (topAsteroid == Math.abs(currentAsteroid)) {
                    // Both explode
                    stack.removeLast();
                    currentAsteroid = 0; // Mark current asteroid as exploded
                    break; // No further collisions for this currentAsteroid
                } else {
                    // Current asteroid explodes
                    currentAsteroid = 0; // Mark current asteroid as exploded
                    break; // No further collisions for this currentAsteroid
                }
            }

            if (currentAsteroid != 0) {
                stack.addLast(currentAsteroid);
            }
        }

        int[] result = new int[stack.size()];
        for (int i = result.length - 1; i >= 0; i--) {
            result[i] = stack.removeLast();
        }

        return result;
    }
}