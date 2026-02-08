class Solution {
    private int calculate(int x, int a, int b, int c) {
        return a * x * x + b * x + c;
    }

    public int[] sortTransformedArray(int[] nums, int a, int b, int c) {
        int n = nums.length;
        int[] res = new int[n];
        if (n == 0) {
            return res;
        }

        int left = 0;
        int right = n - 1;

        if (a >= 0) {
            // Parabola opens upwards (U-shape) or a line with non-decreasing slope.
            // The maximum values are at the ends of the range.
            // Fill the result array from right to left (descending order).
            int idx = n - 1;
            while (left <= right) {
                int valLeft = calculate(nums[left], a, b, c);
                int valRight = calculate(nums[right], a, b, c);
                if (valLeft > valRight) {
                    res[idx--] = valLeft;
                    left++;
                } else {
                    res[idx--] = valRight;
                    right--;
                }
            }
        } else { // a < 0
            // Parabola opens downwards (inverted U-shape) or a line with decreasing slope.
            // The minimum values are at the ends of the range.
            // Fill the result array from left to right (ascending order).
            int idx = 0;
            while (left <= right) {
                int valLeft = calculate(nums[left], a, b, c);
                int valRight = calculate(nums[right], a, b, c);
                if (valLeft < valRight) {
                    res[idx++] = valLeft;
                    left++;
                } else {
                    res[idx++] = valRight;
                    right--;
                }
            }
        }
        return res;
    }
}