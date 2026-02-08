class Solution {
    public int sumOfFlooredPairs(int[] nums) {
        int mod = 1000000007;
        int maxVal = 0;
        for (int num : nums) {
            maxVal = Math.max(maxVal, num);
        }
        int[] counts = new int[maxVal + 1];
        for (int num : nums) {
            counts[num]++;
        }
        for (int i = 1; i <= maxVal; i++) {
            counts[i] += counts[i - 1];
        }
        long ans = 0;
        for (int i = 0; i < nums.length; i++) {
            int num = nums[i];
            int count = 0;
            for (int j = 1; j <= num; j++) {
                int low = num / (j + 1) + 1;
                int high = num / j;
                if (low > maxVal) continue;
                high = Math.min(high, maxVal);
                if (low > high) continue;
                count += counts[high] - counts[low - 1];
            }
            int low = num+1;
            int high = maxVal;

            if(num != 0){
                int j = num;
                int low2 = num / (j + 1) + 1;
                int high2 = num / j;
                if (low2 <= num) {
                    count += counts[num] - counts[low2 - 1];
                }
            }
            else{
                count = counts[0];
            }

            ans = (ans + count) % mod;
        }
        return (int) ans;
    }
}