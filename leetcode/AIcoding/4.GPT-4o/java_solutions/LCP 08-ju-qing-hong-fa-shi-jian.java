class Solution {
    public int[] getTriggerTime(int[][] increase, int[] requirements) {
        int n = increase.length;
        int[] result = new int[n];
        long[] total = new long[requirements.length];
        long[] required = new long[requirements.length];

        for (int i = 0; i < requirements.length; i++) {
            required[i] = requirements[i];
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < requirements.length; j++) {
                total[j] += increase[i][j];
                if (total[j] >= required[j]) {
                    result[i] = Math.max(result[i], (int) (i + 1));
                }
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < requirements.length; j++) {
                if (total[j] < required[j]) {
                    result[i] = -1;
                    break;
                }
            }
        }

        return result;
    }
}