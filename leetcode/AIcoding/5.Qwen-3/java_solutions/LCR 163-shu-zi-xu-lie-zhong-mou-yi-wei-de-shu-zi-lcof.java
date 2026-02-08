public class Solution {
    public int findKthNumber(int n, int k) {
        long number = 1;
        k--;
        while (k > 0) {
            long steps = 0;
            long first = number;
            long last = number + 1;
            while (first <= n) {
                steps += Math.min(n + 1, last) - first;
                first *= 10;
                last *= 10;
            }
            if (k >= steps) {
                k -= steps;
                number++;
            } else {
                k--;
                number *= 10;
            }
        }
        return (int) number;
    }
}