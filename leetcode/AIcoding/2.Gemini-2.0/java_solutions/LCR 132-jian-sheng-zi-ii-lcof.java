class Solution {
    public int minOperations(int[] bamboo) {
        int n = bamboo.length;
        int ans = 0;
        while (true) {
            int count = 0;
            double maxVal = 0;
            int maxIndex = -1;
            for (int i = 0; i < n; i++) {
                if (bamboo[i] > 0) {
                    count++;
                }
                if (bamboo[i] > maxVal) {
                    maxVal = bamboo[i];
                    maxIndex = i;
                }
            }
            if (count == 0) {
                break;
            }
            if (count == 1) {
                ans += bamboo[maxIndex];
                bamboo[maxIndex] = 0;
            } else {
                double nextVal = Math.ceil(Math.sqrt(maxVal));
                if (nextVal == maxVal) {
                    nextVal = maxVal - 1;
                }
                bamboo[maxIndex] = (int) nextVal;
                ans++;
            }
        }
        return ans;
    }
}