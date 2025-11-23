class Solution {
    public int[] findMissingAndRepeatedValues(int[] nums) {
        int n = nums.length;
        int[] result = new int[2];
        int[] count = new int[n + 1];

        for (int num : nums) {
            count[num]++;
        }

        for (int i = 1; i <= n; i++) {
            if (count[i] == 0) {
                result[1] = i;
            } else if (count[i] > 1) {
                result[0] = i;
            }
        }

        return result;
    }
}