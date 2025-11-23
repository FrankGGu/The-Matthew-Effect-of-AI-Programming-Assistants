class Solution {
    public int numDecodings(String s) {
        int n = s.length();

        int two_back = 1; 

        int one_back = (s.charAt(0) == '0') ? 0 : 1;

        for (int i = 2; i <= n; i++) {
            int current = 0;

            int digit1 = s.charAt(i - 1) - '0';
            if (digit1 != 0) {
                current += one_back;
            }

            int digit2 = s.charAt(i - 2) - '0';
            int two_digit_num = digit2 * 10 + digit1;

            if (digit2 != 0 && two_digit_num >= 10 && two_digit_num <= 26) {
                current += two_back;
            }

            two_back = one_back;
            one_back = current;
        }

        return one_back; 
    }
}