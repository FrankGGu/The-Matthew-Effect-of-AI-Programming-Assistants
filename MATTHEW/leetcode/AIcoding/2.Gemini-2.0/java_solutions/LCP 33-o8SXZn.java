public class Solution {
    public int storeWater(int[] bucket, int[] vat) {
        int n = bucket.length;
        int maxVat = 0;
        for (int v : vat) {
            maxVat = Math.max(maxVat, v);
        }
        if (maxVat == 0) {
            return 0;
        }

        int ans = Integer.MAX_VALUE;
        for (int k = 1; k <= maxVat; k++) {
            int cur = k;
            for (int i = 0; i < n; i++) {
                int times = (vat[i] + k - 1) / k;
                cur += Math.max(0, times - bucket[i]);
            }
            ans = Math.min(ans, cur);
        }
        return ans;
    }
}