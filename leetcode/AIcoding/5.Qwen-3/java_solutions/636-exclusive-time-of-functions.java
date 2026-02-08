public class Solution {

import java.util.*;

public class Solution {
    public int[] exclusiveTime(int n, String[] logs) {
        int[] result = new int[n];
        Stack<Integer> stack = new Stack<>();
        int prevTime = 0;

        for (String log : logs) {
            String[] parts = log.split(":");
            int id = Integer.parseInt(parts[0]);
            String type = parts[1];
            int time = Integer.parseInt(parts[2]);

            if (!stack.isEmpty()) {
                result[stack.peek()] += time - prevTime;
            }

            if (type.equals("start")) {
                stack.push(id);
            } else {
                stack.pop();
            }

            prevTime = time;
        }

        return result;
    }
}
}