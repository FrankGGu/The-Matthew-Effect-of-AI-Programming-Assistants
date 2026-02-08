class Solution {
    public boolean canComplete(int[] A, int[] B, int target) {
        int total = 0;
        for (int a : A) total += a;
        for (int b : B) total -= b;
        return total >= target;
    }

    public boolean canCompleteTraining(int[] A, int[] B, int target) {
        int n = A.length;
        int m = B.length;
        for (int i = 0; i < n; i++) {
            if (!canComplete(A, B, target - A[i])) {
                return false;
            }
        }
        return true;
    }

    public boolean canFinish(int target, int[] A, int[] B) {
        return canCompleteTraining(A, B, target);
    }
}