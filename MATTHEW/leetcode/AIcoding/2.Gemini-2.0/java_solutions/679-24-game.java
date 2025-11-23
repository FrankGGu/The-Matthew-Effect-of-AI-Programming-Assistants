class Solution {
    public boolean judgePoint24(int[] nums) {
        double[] arr = new double[nums.length];
        for (int i = 0; i < nums.length; i++) {
            arr[i] = (double) nums[i];
        }
        return solve(arr);
    }

    private boolean solve(double[] nums) {
        if (nums.length == 1) {
            return Math.abs(nums[0] - 24) < 1e-6;
        }

        for (int i = 0; i < nums.length; i++) {
            for (int j = i + 1; j < nums.length; j++) {
                double[] next = new double[nums.length - 1];
                int k = 0;
                for (int l = 0; l < nums.length; l++) {
                    if (l != i && l != j) {
                        next[k++] = nums[l];
                    }
                }

                next[k] = nums[i] + nums[j];
                if (solve(next)) return true;

                next[k] = nums[i] - nums[j];
                if (solve(next)) return true;

                next[k] = nums[j] - nums[i];
                if (solve(next)) return true;

                next[k] = nums[i] * nums[j];
                if (solve(next)) return true;

                if (Math.abs(nums[j]) > 1e-6) {
                    next[k] = nums[i] / nums[j];
                    if (solve(next)) return true;
                }

                if (Math.abs(nums[i]) > 1e-6) {
                    next[k] = nums[j] / nums[i];
                    if (solve(next)) return true;
                }
            }
        }

        return false;
    }
}