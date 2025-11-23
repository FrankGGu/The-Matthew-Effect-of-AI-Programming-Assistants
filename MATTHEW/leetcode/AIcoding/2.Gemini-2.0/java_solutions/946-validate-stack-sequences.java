import java.util.Stack;

class Solution {
    public boolean validateStackSequences(int[] pushed, int[] popped) {
        Stack<Integer> stack = new Stack<>();
        int i = 0, j = 0;
        while (i < pushed.length || !stack.isEmpty()) {
            if (!stack.isEmpty() && stack.peek() == popped[j]) {
                stack.pop();
                j++;
            } else if (i < pushed.length) {
                stack.push(pushed[i]);
                i++;
            } else {
                return false;
            }
        }
        return true;
    }
}