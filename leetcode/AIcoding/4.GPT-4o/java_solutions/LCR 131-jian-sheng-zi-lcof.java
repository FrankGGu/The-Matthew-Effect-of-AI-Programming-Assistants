class Solution {
    public int cutTree(int[] heights, int target) {
        int left = 0, right = 0;
        for (int height : heights) {
            right = Math.max(right, height);
        }

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canCut(heights, mid, target)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }

    private boolean canCut(int[] heights, int height, int target) {
        int sum = 0;
        for (int h : heights) {
            if (h > height) {
                sum += h - height;
            }
        }
        return sum >= target;
    }
}