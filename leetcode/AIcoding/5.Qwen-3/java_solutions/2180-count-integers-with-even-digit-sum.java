public class Solution {
    public int countEven(int n) {
        int count = 0;
        for (int i = 1; i <= n; i++) {
            int sum = 0;
            int num = i;
            while (num > 0) {
                sum += num % 10;
                num /= 10;
            }
            if (sum % 2 == 0) {
                count++;
            }
        }
        return count;
    }
}