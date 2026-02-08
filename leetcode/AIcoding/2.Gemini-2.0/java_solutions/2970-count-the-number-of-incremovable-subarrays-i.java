class Solution {
    public int incremovableSubarrayCount(int[] nums) {
        int n = nums.length;
        int count = 0;

        for (int i = 0; i <= n; i++) {
            for (int j = i; j <= n; j++) {
                int[] temp = new int[n - (j - i)];
                int k = 0;
                for (int l = 0; l < i; l++) {
                    temp[k++] = nums[l];
                }
                for (int l = j; l < n; l++) {
                    temp[k++] = nums[l];
                }

                boolean increasing = true;
                for (int l = 1; l < temp.length; l++) {
                    if (temp[l] <= temp[l - 1]) {
                        increasing = false;
                        break;
                    }
                }

                if (increasing) {
                    count++;
                }
            }
        }

        return count;
    }
}