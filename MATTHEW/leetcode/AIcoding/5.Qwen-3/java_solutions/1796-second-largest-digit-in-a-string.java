public class Solution {
    public int secondHighest(String s) {
        int max = -1;
        int secondMax = -1;

        for (char c : s.toCharArray()) {
            if (Character.isDigit(c)) {
                int num = c - '0';
                if (num > max) {
                    secondMax = max;
                    max = num;
                } else if (num < max && num > secondMax) {
                    secondMax = num;
                }
            }
        }

        return secondMax;
    }
}