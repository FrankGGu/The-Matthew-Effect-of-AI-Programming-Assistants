import java.util.ArrayDeque;
import java.util.Deque;

class Solution {
    public String removeKdigits(String num, int k) {
        Deque<Character> stack = new ArrayDeque<>();

        for (char digit : num.toCharArray()) {
            while (!stack.isEmpty() && k > 0 && stack.peekLast() > digit) {
                stack.removeLast();
                k--;
            }
            stack.addLast(digit);
        }

        while (k > 0 && !stack.isEmpty()) {
            stack.removeLast();
            k--;
        }

        StringBuilder sb = new StringBuilder();
        boolean leadingZero = true;
        for (char digit : stack) {
            if (leadingZero && digit == '0') {
                continue;
            }
            leadingZero = false;
            sb.append(digit);
        }

        if (sb.length() == 0) {
            return "0";
        }

        return sb.toString();
    }
}