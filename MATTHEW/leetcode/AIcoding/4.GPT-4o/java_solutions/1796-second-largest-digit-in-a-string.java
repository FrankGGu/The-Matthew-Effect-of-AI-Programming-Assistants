class Solution {
    public int secondHighest(String s) {
        int first = -1, second = -1;
        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                int digit = c - '0';
                if (digit > first) {
                    second = first;
                    first = digit;
                } else if (digit > second && digit < first) {
                    second = digit;
                }
            }
        }
        return second;
    }
}