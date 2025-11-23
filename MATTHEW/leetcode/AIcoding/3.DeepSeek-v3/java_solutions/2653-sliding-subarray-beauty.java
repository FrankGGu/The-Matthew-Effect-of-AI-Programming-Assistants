class Solution {
    public int[] getSubarrayBeauty(int[] nums, int k, int x) {
        int n = nums.length;
        int[] result = new int[n - k + 1];
        int[] freq = new int[101]; // -50 to 50 mapped to 0 to 100

        for (int i = 0; i < k; i++) {
            freq[nums[i] + 50]++;
        }

        result[0] = findXthSmallest(freq, x);

        for (int i = k; i < n; i++) {
            freq[nums[i - k] + 50]--;
            freq[nums[i] + 50]++;
            result[i - k + 1] = findXthSmallest(freq, x);
        }

        return result;
    }

    private int findXthSmallest(int[] freq, int x) {
        int count = 0;
        for (int i = 0; i <= 100; i++) {
            count += freq[i];
            if (count >= x) {
                int num = i - 50;
                return num < 0 ? num : 0;
            }
        }
        return 0;
    }
}