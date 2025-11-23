public class Solution {

import java.util.*;

public class CarFleetII {
    public int[] getCollisionTimes(int[][] cars) {
        int n = cars.length;
        int[] result = new int[n];
        Arrays.fill(result, -1);
        Stack<Integer> stack = new Stack<>();

        for (int i = n - 1; i >= 0; i--) {
            int[] current = cars[i];
            while (!stack.isEmpty()) {
                int j = stack.peek();
                int[] next = cars[j];
                if (current[1] <= next[1]) {
                    stack.pop();
                } else {
                    int timeToCollision = (next[0] - current[0]) / (current[1] - next[1]);
                    if (result[j] == -1 || timeToCollision < result[j]) {
                        result[i] = timeToCollision;
                    }
                    break;
                }
            }
            stack.push(i);
        }

        return result;
    }
}
}