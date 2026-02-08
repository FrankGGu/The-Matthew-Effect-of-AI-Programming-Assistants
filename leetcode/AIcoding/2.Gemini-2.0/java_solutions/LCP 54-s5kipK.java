class Solution {
    public int captureForts(int[] forts) {
        int max = 0;
        int last = -1;
        for (int i = 0; i < forts.length; i++) {
            if (forts[i] != 0) {
                if (last != -1 && forts[i] != forts[last]) {
                    int count = 0;
                    for (int j = last + 1; j < i; j++) {
                        if (forts[j] == 0) {
                            count++;
                        }
                    }
                    max = Math.max(max, count);
                }
                last = i;
            }
        }
        return max;
    }
}