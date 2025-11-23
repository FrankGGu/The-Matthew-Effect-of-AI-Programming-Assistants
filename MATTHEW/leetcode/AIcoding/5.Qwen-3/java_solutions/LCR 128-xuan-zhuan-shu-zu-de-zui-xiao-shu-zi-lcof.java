public class Solution {
    public int inventoryManagement(int[] stock, int cnt) {
        if (stock == null || cnt <= 0) return 0;
        java.util.Arrays.sort(stock);
        return stock[cnt - 1];
    }
}