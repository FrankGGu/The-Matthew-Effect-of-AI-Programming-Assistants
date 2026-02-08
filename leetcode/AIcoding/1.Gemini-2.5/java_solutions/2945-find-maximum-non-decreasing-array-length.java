class Solution {
    public int findMaximumNonDecreasingArrayLength(int[] nums) {
        if (nums == null || nums.length == 0) {
            return 0;
        }

        int[] tails = new int[nums.length];
        int len = 0;

        for (int num : nums) {
            int low = 0, high = len;
            while (low < high) {
                int mid = low + (high - low) / 2;
                if (tails[mid] <= num) {
                    low = mid + 1;
                } else {
                    high = mid;
                }
            }
            int insertionPoint = low;

            if (insertionPoint == len) {
                tails[len++] = num;
            } else {
                tails[insertionPoint] = num;
            }
        }

        return len;
    }
}