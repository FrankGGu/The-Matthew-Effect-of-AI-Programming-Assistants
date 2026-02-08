class Solution {
    public boolean isValid(String s) {
        Stack<Character> stack = new Stack<>();
        for (char c : s.toCharArray()) {
            if (c == 'c') {
                if (stack.size() < 2) return false;
                char b = stack.pop();
                char a = stack.pop();
                if (b != 'b' || a != 'a') return false;
            } else {
                stack.push(c);
            }
        }
        return stack.isEmpty();
    }
}