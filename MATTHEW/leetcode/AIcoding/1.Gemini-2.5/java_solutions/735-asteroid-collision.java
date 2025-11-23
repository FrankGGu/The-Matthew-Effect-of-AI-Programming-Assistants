import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public int[] asteroidCollision(int[] asteroids) {
        Deque<Integer> stack = new ArrayDeque<>();

        for (int asteroid : asteroids) {
            boolean currentAsteroidDestroyed = false;
            while (!stack.isEmpty() && asteroid < 0 && stack.peekLast() > 0) {
                int topAsteroid = stack.peekLast();

                if (Math.abs(asteroid) > topAsteroid) {
                    stack.removeLast();
                } else if (Math.abs(asteroid) == topAsteroid) {
                    stack.removeLast();
                    currentAsteroidDestroyed = true;
                    break;
                } else {
                    currentAsteroidDestroyed = true;
                    break;
                }
            }

            if (!currentAsteroidDestroyed) {
                stack.addLast(asteroid);
            }
        }

        int[] result = new int[stack.size()];
        for (int i = result.length - 1; i >= 0; i--) {
            result[i] = stack.removeLast();
        }
        return result;
    }
}