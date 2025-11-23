class Solution {
    public int[] sumEvenAfterQueries(int[] A, int[][] queries) {
        int[] result = new int[queries.length];
        int sumEven = 0;
        for (int num : A) {
            if (num % 2 == 0) {
                sumEven += num;
            }
        }

        for (int i = 0; i < queries.length; i++) {
            int val = queries[i][0];
            int index = queries[i][1];
            if (A[index] % 2 == 0) {
                sumEven -= A[index];
            }
            A[index] += val;
            if (A[index] % 2 == 0) {
                sumEven += A[index];
            }
            result[i] = sumEven;
        }

        return result;
    }
}