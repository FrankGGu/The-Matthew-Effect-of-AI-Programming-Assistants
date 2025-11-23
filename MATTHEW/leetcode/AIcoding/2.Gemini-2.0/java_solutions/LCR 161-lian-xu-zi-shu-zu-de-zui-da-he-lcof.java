class Solution {
    public int[] solve(int[] sales, int days) {
        if (sales == null || sales.length == 0 || days <= 0 || days > sales.length) {
            return new int[0];
        }

        int[] result = new int[sales.length - days + 1];
        for (int i = 0; i <= sales.length - days; i++) {
            int sum = 0;
            for (int j = 0; j < days; j++) {
                sum += sales[i + j];
            }
            result[i] = sum;
        }
        return result;
    }
}