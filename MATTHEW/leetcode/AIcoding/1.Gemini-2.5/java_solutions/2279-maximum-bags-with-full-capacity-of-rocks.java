import java.util.Arrays;

class Solution {
    public int maximumBags(int[] capacity, int[] rocks, int additionalRocks) {
        int n = capacity.length;
        int[] diffs = new int[n];

        for (int i = 0; i < n; i++) {
            diffs[i] = capacity[i] - rocks[i];
        }

        Arrays.sort(diffs);

        int fullBagsCount = 0;
        for (int diff : diffs) {
            if (diff == 0) {
                fullBagsCount++;
            } else if (additionalRocks >= diff) {
                additionalRocks -= diff;
                fullBagsCount++;
            } else {
                break;
            }
        }

        return fullBagsCount;
    }
}