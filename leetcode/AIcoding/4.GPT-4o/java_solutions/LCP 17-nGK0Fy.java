class Solution {
    public boolean calculate(String s) {
        int total = 0;
        int num = 0;
        char sign = '+';
        for (int i = 0; i < s.length(); i++) {
            if (Character.isDigit(s.charAt(i))) {
                num = num * 10 + (s.charAt(i) - '0');
            }
            if (!Character.isDigit(s.charAt(i)) && s.charAt(i) != ' ' || i == s.length() - 1) {
                if (sign == '+') total += num;
                else if (sign == '-') total -= num;
                else if (sign == '*') total *= num;
                else if (sign == '/') total /= num;
                sign = s.charAt(i);
                num = 0;
            }
        }
        return total == 0;
    }
}