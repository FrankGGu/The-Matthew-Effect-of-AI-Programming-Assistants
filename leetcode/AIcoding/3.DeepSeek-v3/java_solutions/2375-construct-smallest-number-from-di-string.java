class Solution {
    public String smallestNumber(String pattern) {
        int n = pattern.length();
        StringBuilder res = new StringBuilder();
        StringBuilder stack = new StringBuilder();
        for (int i = 0; i <= n; i++) {
            stack.append((char)('1' + i));
            if (i == n || pattern.charAt(i) == 'I') {
                res.append(stack.reverse());
                stack = new StringBuilder();
            }
        }
        return res.toString();
    }
}