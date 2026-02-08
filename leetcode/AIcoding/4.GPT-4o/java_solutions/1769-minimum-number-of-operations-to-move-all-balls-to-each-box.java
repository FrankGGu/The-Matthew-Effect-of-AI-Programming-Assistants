class Solution {
    public int[] minOperations(String boxes) {
        int n = boxes.length();
        int[] result = new int[n];
        int operations = 0, balls = 0;

        for (int i = 0; i < n; i++) {
            result[i] = operations;
            if (boxes.charAt(i) == '1') {
                balls++;
            }
            operations += balls;
        }

        operations = 0;
        balls = 0;

        for (int i = n - 1; i >= 0; i--) {
            result[i] += operations;
            if (boxes.charAt(i) == '1') {
                balls++;
            }
            operations += balls;
        }

        return result;
    }
}