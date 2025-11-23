public class Solution {

import java.util.*;

public class Solution {
    public List<Integer> asteroidCollision(int[] asteroids) {
        Stack<Integer> stack = new Stack<>();
        for (int asteroid : asteroids) {
            boolean collide = false;
            while (!stack.isEmpty() && stack.peek() > 0 && asteroid < 0) {
                if (stack.peek() < -asteroid) {
                    stack.pop();
                } else if (stack.peek() == -asteroid) {
                    stack.pop();
                    collide = true;
                    break;
                } else {
                    collide = true;
                    break;
                }
            }
            if (!collide) {
                stack.push(asteroid);
            }
        }
        return new ArrayList<>(stack);
    }
}
}