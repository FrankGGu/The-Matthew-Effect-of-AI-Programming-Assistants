import java.util.Arrays;

class Solution {
    public int minWastedSpace(int[] packages, int[][] boxes) {
        Arrays.sort(packages);
        long totalSum = 0;
        for (int p : packages) {
            totalSum += p;
        }
        long minWaste = Long.MAX_VALUE;
        for (int[] box : boxes) {
            Arrays.sort(box);
            if (box[box.length - 1] < packages[packages.length - 1]) {
                continue;
            }
            long currentWaste = 0;
            int left = 0;
            for (int b : box) {
                int right = findUpperBound(packages, b, left);
                if (right == -1) {
                    break;
                }
                currentWaste += (long) b * (right - left + 1);
                left = right + 1;
                if (left >= packages.length) {
                    break;
                }
            }
            if (left >= packages.length) {
                minWaste = Math.min(minWaste, currentWaste - totalSum);
            }
        }
        return minWaste == Long.MAX_VALUE ? -1 : (int) (minWaste % 1_000_000_007);
    }

    private int findUpperBound(int[] packages, int target, int left) {
        int right = packages.length - 1;
        int result = -1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (packages[mid] <= target) {
                result = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return result;
    }
}