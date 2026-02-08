import java.util.ArrayDeque;
import java.util.Deque;
import java.util.List;
import java.util.ArrayList;
import java.util.Arrays;

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
            char dir = directions.charAt(i);
            if (dir == 'R') {
                stack.push(i);
            } else {
                while (!stack.isEmpty()) {
                    int top = stack.peek();
                    if (healths[top] > healths[i]) {
                        healths[top]--;
                        healths[i] = 0;
                        break;
                    } else if (healths[top] < healths[i]) {
                        healths[top] = 0;
                        healths[i]--;
                        stack.pop();
                    } else {
                        healths[top] = 0;
                        healths[i] = 0;
                        stack.pop();
                        break;
                    }
                }
                if (healths[i] > 0) {
                    stack.push(i);
                }
            }
        }

        List<Integer> result = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            if (healths[i] > 0) {
                result.add(healths[i]);
            }
        }

        return result;
    }
}