class Solution {
    public int[] getTriggerTime(int[][] increase, int[][] requirements) {
        int n = requirements.length;
        int[] res = new int[n];
        for (int i = 0; i < n; i++) {
            res[i] = -1;
        }

        int c = 0, r = 0, h = 0;

        for (int i = 0; i < increase.length; i++) {
            c += increase[i][0];
            r += increase[i][1];
            h += increase[i][2];

            for (int j = 0; j < n; j++) {
                if (res[j] == -1 && c >= requirements[j][0] && r >= requirements[j][1] && h >= requirements[j][2]) {
                    res[j] = i + 1;
                }
            }
        }

        for (int j = 0; j < n; j++) {
            if (res[j] == -1 && 0 >= requirements[j][0] && 0 >= requirements[j][1] && 0 >= requirements[j][2]) {
                res[j] = 0;
            }
        }

        return res;
    }
}