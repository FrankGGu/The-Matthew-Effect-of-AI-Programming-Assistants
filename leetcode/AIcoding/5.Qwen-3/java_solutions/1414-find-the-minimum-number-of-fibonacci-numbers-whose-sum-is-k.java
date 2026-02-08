public class Solution {

import java.util.*;

public class Solution {
    public int findMinFibonacciNumbers(int k) {
        List<Integer> fibs = new ArrayList<>();
        int a = 1, b = 1;
        fibs.add(a);
        while (b <= k) {
            fibs.add(b);
            int next = a + b;
            a = b;
            b = next;
        }
        int count = 0;
        for (int i = fibs.size() - 1; i >= 0; i--) {
            if (k >= fibs.get(i)) {
                k -= fibs.get(i);
                count++;
            }
            if (k == 0) break;
        }
        return count;
    }
}
}