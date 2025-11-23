class Solution {
    public int[] findValley(int[] height) {
        int n = height.length;
        if (n < 3) return new int[]{-1, -1, -1};

        for (int i = 1; i < n - 1; i++) {
            if (height[i] < height[i - 1] && height[i] < height[i + 1]) {
                int left = i - 1;
                while (left > 0 && height[left - 1] >= height[left]) {
                    left--;
                }

                int right = i + 1;
                while (right < n - 1 && height[right + 1] >= height[right]) {
                    right++;
                }

                return new int[]{left, i, right};
            }
        }

        return new int[]{-1, -1, -1};
    }
}