class Solution {
    public String largestPalindromic(String num) {
        int[] count = new int[10];
        for (char c : num.toCharArray()) {
            count[c - '0']++;
        }

        StringBuilder left = new StringBuilder();
        int singleDigit = -1;

        for (int i = 9; i >= 0; i--) {
            if (i == 0 && left.length() == 0) {
                break;
            }
            int pairs = count[i] / 2;
            for (int j = 0; j < pairs; j++) {
                left.append(i);
            }
            if (count[i] % 2 == 1 && singleDigit == -1) {
                singleDigit = i;
            }
        }

        StringBuilder right = new StringBuilder(left).reverse();
        StringBuilder result = new StringBuilder(left);

        if (singleDigit != -1) {
            result.append(singleDigit);
        }

        result.append(right);

        if (result.length() == 0) {
            return "0";
        }
        return result.toString();
    }
}