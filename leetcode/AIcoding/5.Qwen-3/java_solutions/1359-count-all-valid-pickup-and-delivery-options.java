public class Solution {
    public int countPlaceOrders(int n) {
        long result = 1;
        for (int i = 2; i <= n; i++) {
            result = result * (2 * i - 1) * i % (1000000007);
        }
        return (int) result;
    }
}