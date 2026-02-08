public class Solution {
    public int numberOfUniqueNumbers(int n) {
        int count = 0;
        boolean[] seen = new boolean[10];
        for (int i = 0; i < n; i++) {
            int num = i;
            while (num > 0) {
                int digit = num % 10;
                if (!seen[digit]) {
                    seen[digit] = true;
                    count++;
                }
                num /= 10;
            }
        }
        return count;
    }
}