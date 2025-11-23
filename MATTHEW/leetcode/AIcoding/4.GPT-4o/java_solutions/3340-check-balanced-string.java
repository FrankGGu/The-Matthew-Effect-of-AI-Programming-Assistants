class Solution {
    public boolean checkBalancedString(String s) {
        int balance = 0;
        for (char c : s.toCharArray()) {
            if (c == '(') balance++;
            else if (c == ')') balance--;
            else if (c == '[') balance++;
            else if (c == ']') balance--;
            else if (c == '{') balance++;
            else if (c == '}') balance--;
        }
        return balance == 0;
    }
}