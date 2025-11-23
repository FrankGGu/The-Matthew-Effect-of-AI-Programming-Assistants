class Solution {
    public int[] countAlternatingSubarrays(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            int count = 0;
            for (int j = i; j < n; j++) {
                if (j - i + 1 >= 2) {
                    boolean alternating = true;
                    for (int k = i; k < j; k++) {
                        if ((nums[k] + nums[k + 1]) % 2 != 1) {
                            alternating = false;
                            break;
                        }
                    }
                    if (alternating) {
                        count++;
                    }
                }
            }
            result[i] = count;
        }
        return result;
    }
}