class Solution {
    public String largestPalindromic(String num) {
        int[] count = new int[10];
        for (char c : num.toCharArray()) {
            count[c - '0']++;
        }

        StringBuilder half = new StringBuilder();
        StringBuilder middle = new StringBuilder();

        for (int i = 9; i >= 0; i--) {
            if (count[i] > 0) {
                half.append(String.valueOf(i).repeat(count[i] / 2));
                if (count[i] % 2 == 1 && middle.length() == 0) {
                    middle.append(i);
                }
            }
        }

        String result = half.toString();
        if (result.isEmpty() && middle.length() == 0) {
            return "0";
        }

        StringBuilder palindromic = new StringBuilder(result);
        if (middle.length() > 0) {
            palindromic.append(middle);
        }
        palindromic.append(half.reverse());

        return palindromic.toString();
    }
}