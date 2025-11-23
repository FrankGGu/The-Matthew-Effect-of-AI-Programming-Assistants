public class Solution {
    public int totalMoney(int n) {
        int total = 0;
        int week = 0;
        while (n > 0) {
            for (int i = 0; i < 7 && n > 0; i++) {
                total += week + i + 1;
                n--;
            }
            week++;
        }
        return total;
    }
}