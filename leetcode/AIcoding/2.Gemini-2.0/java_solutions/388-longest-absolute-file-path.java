import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int lengthLongestPath(String input) {
        Deque<Integer> stack = new LinkedList<>();
        stack.push(0);
        int maxLen = 0;
        for (String s : input.split("\n")) {
            int level = s.lastIndexOf("\t") + 1;
            while (level < stack.size() - 1) {
                stack.pop();
            }
            int len = stack.peek() + s.length() - level + 1;
            stack.push(len);
            if (s.contains(".")) {
                maxLen = Math.max(maxLen, len - 1);
            }
        }
        return maxLen;
    }
}