class Solution {
    public int maxSales(int[] sales) {
        int max = sales[0];
        int current = sales[0];
        for (int i = 1; i < sales.length; i++) {
            current = Math.max(sales[i], current + sales[i]);
            max = Math.max(max, current);
        }
        return max;
    }
}