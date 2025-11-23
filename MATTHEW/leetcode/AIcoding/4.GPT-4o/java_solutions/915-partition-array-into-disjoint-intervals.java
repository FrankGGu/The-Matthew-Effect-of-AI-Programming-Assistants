class Solution {
    public int partitionDisjoint(int[] A) {
        int n = A.length;
        int maxLeft = A[0], maxSoFar = A[0], partitionIndex = 0;

        for (int i = 1; i < n; i++) {
            if (A[i] < maxLeft) {
                partitionIndex = i;
                maxLeft = maxSoFar;
            }
            maxSoFar = Math.max(maxSoFar, A[i]);
        }

        return partitionIndex + 1;
    }
}