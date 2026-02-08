public class Solution {
    public int findKthNumber(int n, int k) {
        long current = 1;
        k -= 1;
        while (k > 0) {
            long steps = 0;
            long first = current;
            long last = current + 1;
            while (first <= n) {
                steps += Math.min(n + 1, last) - first;
                first *= 10;
                last *= 10;
            }
            if (k >= steps) {
                k -= steps;
                current += 1;
            } else {
                k -= 1;
                current *= 10;
            }
        }
        return (int) current;
    }
}