import java.util.List;
import java.util.Stack;

class Solution {
    public int[] exclusiveTime(int n, List<String> logs) {
        int[] result = new int[n];
        Stack<Integer> stack = new Stack<>();
        int prevTime = 0;

        for (String log : logs) {
            String[] parts = log.split(":");
            int functionId = Integer.parseInt(parts[0]);
            String type = parts[1];
            int timestamp = Integer.parseInt(parts[2]);

            if (type.equals("start")) {
                if (!stack.isEmpty()) {
                    result[stack.peek()] += timestamp - prevTime;
                }
                stack.push(functionId);
                prevTime = timestamp;
            } else { // type.equals("end")
                result[stack.peek()] += timestamp - prevTime + 1;
                stack.pop();
                prevTime = timestamp + 1;
            }
        }

        return result;
    }
}