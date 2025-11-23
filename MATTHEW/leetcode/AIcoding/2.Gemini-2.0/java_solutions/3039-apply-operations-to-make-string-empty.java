import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public String makeStringEmpty(String s) {
        int n = s.length();
        Deque<Integer> stack = new ArrayDeque<>();
        boolean[] removed = new boolean[n];
        for (int i = 0; i < n; i++) {
            if (!removed[i]) {
                while (!stack.isEmpty() && s.charAt(stack.peek()) < s.charAt(i)) {
                    removed[stack.pop()] = true;
                }
                stack.push(i);
            }
        }
        StringBuilder sb = new StringBuilder();
        Deque<Character> deque = new ArrayDeque<>();
        for (int i = 0; i < n; i++) {
            if (!removed[i]) {
                deque.offer(s.charAt(i));
            }
        }
        while (!deque.isEmpty()) {
            sb.append(deque.poll());
        }
        return sb.toString();
    }
}