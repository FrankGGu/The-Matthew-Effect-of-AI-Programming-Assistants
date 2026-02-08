class Solution {
    public int countTarget(int[] scores, int target) {
        int left = findFirst(scores, target);
        if (left == -1) {
            return 0;
        }
        int right = findLast(scores, target);
        return right - left + 1;
    }

    private int findFirst(int[] scores, int target) {
        int left = 0;
        int right = scores.length - 1;
        int index = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (scores[mid] >= target) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
            if (scores[mid] == target) {
                index = mid;
            }
        }
        return index;
    }

    private int findLast(int[] scores, int target) {
        int left = 0;
        int right = scores.length - 1;
        int index = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (scores[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
            if (scores[mid] == target) {
                index = mid;
            }
        }
        return index;
    }
}