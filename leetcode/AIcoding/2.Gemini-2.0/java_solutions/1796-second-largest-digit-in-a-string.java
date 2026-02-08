class Solution {
    public int secondHighest(String s) {
        int max1 = -1;
        int max2 = -1;

        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                int digit = c - '0';
                if (digit > max1) {
                    max2 = max1;
                    max1 = digit;
                } else if (digit < max1 && digit > max2) {
                    max2 = digit;
                }
            }
        }

        return max2;
    }
}