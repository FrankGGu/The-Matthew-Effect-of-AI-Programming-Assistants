class Solution {
    public int maximumBags(int[] capacity, int[] rocks, int additionalRocks) {
        int n = capacity.length;
        int[] remaining = new int[n];
        for (int i = 0; i < n; i++) {
            remaining[i] = capacity[i] - rocks[i];
        }
        Arrays.sort(remaining);
        int fullBags = 0;
        for (int i = 0; i < n; i++) {
            if (additionalRocks >= remaining[i]) {
                additionalRocks -= remaining[i];
                fullBags++;
            } else {
                break;
            }
        }
        return fullBags;
    }
}