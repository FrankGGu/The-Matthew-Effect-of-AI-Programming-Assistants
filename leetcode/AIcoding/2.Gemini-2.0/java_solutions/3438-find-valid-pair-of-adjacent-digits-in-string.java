class Solution {
    public boolean isValid(String num) {
        for (int i = 0; i < num.length() - 1; i++) {
            int digit1 = num.charAt(i) - '0';
            int digit2 = num.charAt(i + 1) - '0';
            if ((digit1 + digit2) % 2 == 0) {
                return true;
            }
        }
        return false;
    }
}