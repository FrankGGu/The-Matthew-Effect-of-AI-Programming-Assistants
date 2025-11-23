class Solution {
    public int maxRepOpt1(String text) {
        int[] count = new int[26];
        for (char c : text.toCharArray()) {
            count[c - 'a']++;
        }

        int maxLength = 0, n = text.length();
        for (int i = 0; i < n; i++) {
            char current = text.charAt(i);
            int length = 1, j = i + 1;

            while (j < n && text.charAt(j) == current) {
                length++;
                j++;
            }

            int total = length;
            if (j < n && count[current - 'a'] > length) {
                total++;
            }

            if (i > 0 && text.charAt(i - 1) == current) {
                int k = i - 1;
                while (k >= 0 && text.charAt(k) == current) {
                    length++;
                    k--;
                }
                total = Math.max(total, length);
            }

            maxLength = Math.max(maxLength, total);
            i = j - 1;
        }

        return maxLength;
    }
}