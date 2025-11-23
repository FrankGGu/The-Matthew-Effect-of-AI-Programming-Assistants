class Solution {
    public int captureForts(int[] forts) {
        int max = 0;
        int n = forts.length;
        for (int i = 0; i < n; i++) {
            if (forts[i] == 1) {
                int left = 0;
                for (int j = i - 1; j >= 0; j--) {
                    if (forts[j] == -1) {
                        break;
                    }
                    if (forts[j] == 0) {
                        left++;
                    } else {
                        left = 0;
                        break;
                    }
                }
                int right = 0;
                for (int j = i + 1; j < n; j++) {
                    if (forts[j] == -1) {
                        break;
                    }
                    if (forts[j] == 0) {
                        right++;
                    } else {
                        right = 0;
                        break;
                    }
                }
                max = Math.max(max, Math.max(left, right));
            }
        }
        return max;
    }
}