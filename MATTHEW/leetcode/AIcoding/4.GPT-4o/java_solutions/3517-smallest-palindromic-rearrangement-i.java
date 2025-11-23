class Solution {
    public String smallestPalindromic(String num) {
        int[] count = new int[10];
        for (char c : num.toCharArray()) {
            count[c - '0']++;
        }
        StringBuilder half = new StringBuilder();
        char oddChar = 0;

        for (int i = 1; i < 10; i++) {
            if (count[i] > 0) {
                half.append((char)(i + '0'));
                count[i]--;
            }
        }

        for (int i = 0; i < 10; i++) {
            if (count[i] % 2 == 1) {
                if (oddChar == 0 || i < oddChar) {
                    oddChar = (char)(i + '0');
                }
            }
        }

        StringBuilder pal = new StringBuilder(half);
        if (oddChar != 0) {
            pal.append(oddChar);
        }
        pal.append(half.reverse());

        return pal.length() == 0 ? "0" : pal.toString();
    }
}