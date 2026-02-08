class Solution {
    public String smallestSubsequence(String s, int k, char letter, int repetition) {
        int n = s.length();
        int[] count = new int[n];
        count[n - 1] = (s.charAt(n - 1) == letter) ? 1 : 0;
        for (int i = n - 2; i >= 0; i--) {
            count[i] = count[i + 1] + ((s.charAt(i) == letter) ? 1 : 0;
        }

        Stack<Character> stack = new Stack<>();
        for (int i = 0; i < n; i++) {
            char c = s.charAt(i);
            while (!stack.isEmpty() && stack.peek() > c && (stack.size() - 1 + n - i) >= k && (stack.peek() != letter || count[i] > repetition)) {
                if (stack.peek() == letter) {
                    repetition++;
                }
                stack.pop();
            }
            if (stack.size() < k) {
                if (c == letter) {
                    stack.push(c);
                    repetition--;
                } else if (k - stack.size() > repetition) {
                    stack.push(c);
                }
            } else {
                if (c == letter) {
                    repetition--;
                }
            }
        }

        StringBuilder sb = new StringBuilder();
        while (!stack.isEmpty()) {
            sb.append(stack.pop());
        }
        return sb.reverse().toString();
    }
}