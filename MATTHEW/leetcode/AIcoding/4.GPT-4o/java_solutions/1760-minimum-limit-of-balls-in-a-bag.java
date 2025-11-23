class Solution {
    public int minimumSize(int[] A, int maxOperations) {
        int left = 1, right = 0;
        for (int num : A) {
            right = Math.max(right, num);
        }

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canDistribute(A, mid, maxOperations)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }

        return left;
    }

    private boolean canDistribute(int[] A, int maxSize, int maxOperations) {
        int operations = 0;
        for (int num : A) {
            operations += (num - 1) / maxSize;
            if (operations > maxOperations) {
                return false;
            }
        }
        return true;
    }
}