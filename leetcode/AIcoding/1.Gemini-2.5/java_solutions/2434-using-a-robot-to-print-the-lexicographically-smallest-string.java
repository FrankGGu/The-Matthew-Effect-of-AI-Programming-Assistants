import java.util.Stack;

class Solution {
    public String robotWithString(String s) {
        int n = s.length();
        if (n == 0) {
            return "";
        }

        char[] minChar = new char[n];
        minChar[n - 1] = s.charAt(n - 1);
        for (int i = n - 2; i >= 0; i--) {
            minChar[i] = (char) Math.min(s.charAt(i), minChar[i + 1]);
        }

        StringBuilder p = new StringBuilder();
        Stack<Character> t = new Stack<>();

        for (int i = 0; i < n; i++) {
            char currentSChar = s.charAt(i);
            t.push(currentSChar);

            while (!t.isEmpty() && (i == n - 1 || t.peek() <= minChar[i + 1])) {
                p.append(t.pop());
            }
        }

        return p.toString();
    }
}