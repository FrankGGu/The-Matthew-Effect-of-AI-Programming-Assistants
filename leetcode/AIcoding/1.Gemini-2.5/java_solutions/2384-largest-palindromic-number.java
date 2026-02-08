class Solution {
    public String largestPalindromic(String num) {
        int[] counts = new int[10];
        for (char c : num.toCharArray()) {
            counts[c - '0']++;
        }

        StringBuilder leftHalfBuilder = new StringBuilder();
        for (int d = 9; d >= 0; d--) {
            leftHalfBuilder.append(String.valueOf(d).repeat(counts[d] / 2));
            counts[d] %= 2; 
        }

        char middleDigit = ' ';
        for (int d = 9; d >= 0; d--) {
            if (counts[d] == 1) {
                middleDigit = (char) (d + '0');
                break;
            }
        }

        StringBuilder palindromeBuilder = new StringBuilder();
        palindromeBuilder.append(leftHalfBuilder);
        if (middleDigit != ' ') {
            palindromeBuilder.append(middleDigit);
        }
        palindromeBuilder.append(new StringBuilder(leftHalfBuilder).reverse());

        String result = palindromeBuilder.toString();

        if (result.charAt(0) == '0' && result.length() > 1) {
            boolean allZeros = true;
            for (char c : result.toCharArray()) {
                if (c != '0') {
                    allZeros = false;
                    break;
                }
            }
            if (allZeros) {
                return "0";
            }
        }

        return result;
    }
}