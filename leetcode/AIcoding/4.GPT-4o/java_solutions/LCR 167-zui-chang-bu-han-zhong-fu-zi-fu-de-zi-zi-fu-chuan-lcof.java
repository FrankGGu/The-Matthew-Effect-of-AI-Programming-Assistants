class Solution {
    public int[] solution(int[] A) {
        int n = A.length;
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = A[i] * (i + 1);
        }
        return result;
    }
}