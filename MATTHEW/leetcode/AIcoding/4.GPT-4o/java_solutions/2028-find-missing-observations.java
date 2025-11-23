class Solution {
    public int[] missingObservations(int[] observations, int expected) {
        int n = observations.length;
        int[] result = new int[expected - n];
        int sum = 0;
        for (int observation : observations) {
            sum += observation;
        }
        int totalSum = expected * (expected + 1) / 2;
        int missingSum = totalSum - sum;

        int average = missingSum / (expected - n);
        for (int i = 0; i < result.length; i++) {
            result[i] = average;
        }
        return result;
    }
}