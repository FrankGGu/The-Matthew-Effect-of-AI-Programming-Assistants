class Solution {
    public int captureForts(int[] forts) {
        int maxCaptured = 0;
        int lastFort = -1;
        for (int i = 0; i < forts.length; i++) {
            if (forts[i] != 0) {
                if (lastFort != -1 && forts[i] != forts[lastFort]) {
                    int captured = 0;
                    for (int j = lastFort + 1; j < i; j++) {
                        if (forts[j] == 0) {
                            captured++;
                        }
                    }
                    maxCaptured = Math.max(maxCaptured, captured);
                }
                lastFort = i;
            }
        }
        return maxCaptured;
    }
}