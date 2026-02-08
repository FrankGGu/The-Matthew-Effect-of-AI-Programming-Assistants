class Solution {
    public int[] highestSales(int[][] sales) {
        int n = sales.length;
        int[] result = new int[n];
        int maxSales = 0;
        for (int[] sale : sales) {
            maxSales = Math.max(maxSales, sale[1]);
        }
        for (int i = 0; i < n; i++) {
            if (sales[i][1] == maxSales) {
                result[i] = sales[i][0];
            }
        }
        return result;
    }
}