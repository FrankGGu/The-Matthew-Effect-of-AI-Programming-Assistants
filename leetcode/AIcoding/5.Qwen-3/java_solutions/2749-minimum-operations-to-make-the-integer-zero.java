public class Solution {
    public int minimumOperations(int num) {
        int n = num;
        int count = 0;
        while (n > 0) {
            if (n % 10 == 0) {
                n /= 10;
            } else {
                n -= 1;
            }
            count++;
        }
        return count;
    }
}