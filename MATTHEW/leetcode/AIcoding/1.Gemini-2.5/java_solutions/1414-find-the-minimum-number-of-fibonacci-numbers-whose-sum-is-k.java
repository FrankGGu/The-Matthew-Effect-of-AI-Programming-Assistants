import java.util.ArrayList;
import java.util.List;

class Solution {
    public int findMinFibonacciNumbers(int k) {
        List<Integer> fibNumbers = new ArrayList<>();
        fibNumbers.add(1);
        fibNumbers.add(1);

        while (true) {
            int nextFib = fibNumbers.get(fibNumbers.size() - 1) + fibNumbers.get(fibNumbers.size() - 2);
            if (nextFib > k) {
                break;
            }
            fibNumbers.add(nextFib);
        }

        int count = 0;
        int currentK = k;

        for (int i = fibNumbers.size() - 1; i >= 0; i--) {
            int fib = fibNumbers.get(i);
            if (currentK >= fib) {
                currentK -= fib;
                count++;
            }
            if (currentK == 0) {
                break;
            }
        }

        return count;
    }
}