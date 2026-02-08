class Solution {
    public int smallestMissingNonNegativeInteger(int[] nums, int value) {
        int[] counts = new int[value];
        for (int num : nums) {
            counts[num % value]++;
        }

        for (int k = 0; ; k++) {
            int targetRemainder = k % value;
            if (counts[targetRemainder] > 0) {
                counts[targetRemainder]--;
            } else {
                return k;
            }
        }
    }
}