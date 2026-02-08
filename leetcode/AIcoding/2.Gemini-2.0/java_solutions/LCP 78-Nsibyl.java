class Solution {
    public int defendFort(int[] fort) {
        int maxLen = 0;
        int lastType = 0;
        int start = -1;
        for (int i = 0; i < fort.length; i++) {
            if (fort[i] != 0) {
                if (lastType != 0 && lastType != fort[i]) {
                    if (start != -1) {
                        maxLen = Math.max(maxLen, i - start - 1);
                    }
                }
                lastType = fort[i];
                start = i;
            }
        }
        return maxLen;
    }
}