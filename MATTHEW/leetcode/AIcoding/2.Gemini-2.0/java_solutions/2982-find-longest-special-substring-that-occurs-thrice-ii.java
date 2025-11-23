class Solution {
    public int longestSpecialSubstring(String s) {
        int n = s.length();
        int maxLen = 0;
        for (char c = 'a'; c <= 'z'; c++) {
            int count = 0;
            int len = 0;
            int maxSoFar = 0;
            for (int i = 0; i < n; i++) {
                if (s.charAt(i) == c) {
                    len++;
                } else {
                    maxSoFar = Math.max(maxSoFar, len);
                    len = 0;
                }
            }
            maxSoFar = Math.max(maxSoFar, len);

            len = 0;
            count = 0;
            int[] lengths = new int[n + 1];
            int lengthsCount = 0;

            for (int i = 0; i < n; i++) {
                if (s.charAt(i) == c) {
                    len++;
                } else {
                    if (len > 0) {
                        lengths[lengthsCount++] = len;
                    }
                    len = 0;
                }
            }
            if (len > 0) {
                lengths[lengthsCount++] = len;
            }

            if (lengthsCount == 0) continue;

            for(int i = 0; i < lengthsCount; i++){
                count += lengths[i];
            }

            if(count < 3) continue;

            int currentMax = 0;
            for (int i = 1; i <= maxSoFar; i++) {
                int occurrences = 0;
                for (int j = 0; j < lengthsCount; j++) {
                    if (lengths[j] >= i) {
                        occurrences++;
                    }
                }

                if (occurrences >= 3) {
                    currentMax = i;
                }
            }

            maxLen = Math.max(maxLen, currentMax);

        }
        return maxLen;
    }
}