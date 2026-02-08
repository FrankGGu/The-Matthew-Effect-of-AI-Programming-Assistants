class Solution {
    public int maxRepOpt1(String text) {
        int[] count = new int[26];
        for (char c : text.toCharArray()) {
            count[c - 'a']++;
        }

        int maxLen = 0;
        for (int i = 0; i < text.length(); i++) {
            int j = i;
            while (j < text.length() && text.charAt(i) == text.charAt(j)) {
                j++;
            }
            int currentLen = j - i;

            if (currentLen < count[text.charAt(i) - 'a']) {
                maxLen = Math.max(maxLen, currentLen + 1);
            } else {
                maxLen = Math.max(maxLen, currentLen);
            }

            if (j < text.length()) {
                int k = j + 1;
                while (k < text.length() && text.charAt(i) == text.charAt(k)) {
                    k++;
                }
                int secondLen = k - (j + 1);

                if (currentLen + secondLen < count[text.charAt(i) - 'a']) {
                    maxLen = Math.max(maxLen, currentLen + secondLen + 1);
                } else {
                    maxLen = Math.max(maxLen, currentLen + secondLen);
                }
            }
            i = j - 1;
        }
        return maxLen;
    }
}