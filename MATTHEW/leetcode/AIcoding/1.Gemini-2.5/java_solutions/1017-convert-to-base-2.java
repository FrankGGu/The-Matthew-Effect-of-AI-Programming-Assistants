class Solution {
    public String baseNeg2(int n) {
        if (n == 0) {
            return "0";
        }

        StringBuilder sb = new StringBuilder();
        while (n != 0) {
            int remainder = n % 2;
            if (remainder == 0) {
                sb.append('0');
                n = n / -2;
            } else { // remainder is 1 or -1
                sb.append('1');
                n = (n - 1) / -2;
            }
        }

        return sb.reverse().toString();
    }
}