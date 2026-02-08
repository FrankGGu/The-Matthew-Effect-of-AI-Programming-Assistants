class Solution {
    public String largestPalindromic(String num) {
        int[] count = new int[10];
        for (char c : num.toCharArray()) {
            count[c - '0']++;
        }

        StringBuilder firstHalf = new StringBuilder();
        for (int i = 9; i >= 0; i--) {
            if (firstHalf.length() == 0 && i == 0) continue;
            while (count[i] > 1) {
                firstHalf.append(i);
                count[i] -= 2;
            }
        }

        String middle = "";
        for (int i = 9; i >= 0; i--) {
            if (count[i] > 0) {
                middle = String.valueOf(i);
                break;
            }
        }

        String secondHalf = new StringBuilder(firstHalf).reverse().toString();
        String result = firstHalf.toString() + middle + secondHalf;

        return result.isEmpty() ? "0" : result;
    }
}