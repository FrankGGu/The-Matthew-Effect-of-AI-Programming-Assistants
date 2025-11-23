import java.util.*;

class Solution {
    public List<Integer> survivedRobotsHealths(int[] positions, int[] healths, String directions) {
        int n = positions.length;
        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }
        Arrays.sort(indices, (a, b) -> positions[a] - positions[b]);

        Deque<Integer> stack = new ArrayDeque<>();
        for (int i : indices) {
            if (directions.charAt(i) == 'R') {
                stack.push(i);
                continue;
            }
            while (!stack.isEmpty() && directions.charAt(stack.peek()) == 'R') {
                int top = stack.peek();
                if (healths[top] > healths[i]) {
                    healths[top]--;
                    healths[i] = 0;
                    break;
                } else if (healths[top] < healths[i]) {
                    healths[i]--;
                    healths[top] = 0;
                    stack.pop();
                } else {
                    healths[top] = 0;
                    healths[i] = 0;
                    stack.pop();
                    break;
                }
            }
        }

        List<Integer> result = new ArrayList<>();
        for (int health : healths) {
            if (health > 0) {
                result.add(health);
            }
        }
        return result;
    }
}