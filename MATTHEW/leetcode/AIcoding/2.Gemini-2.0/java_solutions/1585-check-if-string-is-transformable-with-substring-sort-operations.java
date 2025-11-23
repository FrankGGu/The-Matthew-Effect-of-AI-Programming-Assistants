class Solution {
    public boolean isTransformable(String s, String t) {
        int n = s.length();
        int[] pos[] = new int[10][n + 1];
        int[] cnt = new int[10];
        for (int i = 0; i < n; i++) {
            int digit = s.charAt(i) - '0';
            pos[digit][++cnt[digit]] = i;
        }

        int[] idx = new int[10];
        for (int i = 0; i < n; i++) {
            int digit = t.charAt(i) - '0';
            idx[digit]++;
            int curPos = pos[digit][idx[digit]];
            for (int j = 0; j < digit; j++) {
                if (idx[j] < cnt[j] && pos[j][idx[j] + 1] < curPos) {
                    return false;
                }
            }
        }

        return true;
    }
}