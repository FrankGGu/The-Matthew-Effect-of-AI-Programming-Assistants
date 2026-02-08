import java.util.ArrayList;
import java.util.List;

class Solution {
    public int findMinFibonacciNumbers(int k) {
        List<Integer> fib = new ArrayList<>();
        fib.add(1);
        fib.add(1);
        while (true) {
            int nextFib = fib.get(fib.size() - 1) + fib.get(fib.size() - 2);
            if (nextFib > k) break;
            fib.add(nextFib);
        }

        int count = 0;
        for (int i = fib.size() - 1; i >= 0; i--) {
            if (k == 0) break;
            if (fib.get(i) <= k) {
                k -= fib.get(i);
                count++;
            }
        }
        return count;
    }
}