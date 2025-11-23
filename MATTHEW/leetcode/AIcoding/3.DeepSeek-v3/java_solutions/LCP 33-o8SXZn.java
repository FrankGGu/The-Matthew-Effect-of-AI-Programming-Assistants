class Solution {
    public int storeWater(int[] bucket, int[] vat) {
        int maxVat = 0;
        for (int v : vat) {
            maxVat = Math.max(maxVat, v);
        }
        if (maxVat == 0) {
            return 0;
        }
        int minOps = Integer.MAX_VALUE;
        for (int k = 1; k <= maxVat; k++) {
            int ops = 0;
            for (int i = 0; i < bucket.length; i++) {
                int required = (vat[i] + k - 1) / k;
                ops += Math.max(0, required - bucket[i]);
            }
            minOps = Math.min(minOps, ops + k);
            if (k >= minOps) {
                break;
            }
        }
        return minOps;
    }
}