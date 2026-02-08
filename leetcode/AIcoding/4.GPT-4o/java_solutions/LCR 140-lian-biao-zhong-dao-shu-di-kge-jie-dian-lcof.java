class Solution {
    public int[] trainingPlan(int n, int[] strengths) {
        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = strengths[i % strengths.length];
        }
        return result;
    }
}