class Solution {
    public int sumIndicesWithKSetBits(int[] A, int K) {
        int sum = 0;
        for (int i = 0; i < A.length; i++) {
            if (Integer.bitCount(i) == K) {
                sum += A[i];
            }
        }
        return sum;
    }
}