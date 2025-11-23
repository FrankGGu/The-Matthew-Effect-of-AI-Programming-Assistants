public class Solution {

import java.util.*;

public class Solution {
    public int countKReducibleNumbersLessThanN(int n, int k) {
        Set<Integer> reducible = new HashSet<>();
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 1; i <= n; i++) {
            queue.add(i);
        }
        while (!queue.isEmpty()) {
            int num = queue.poll();
            if (num < k) {
                continue;
            }
            if (num % k == 0) {
                reducible.add(num);
                queue.add(num / k);
            } else {
                reducible.add(num);
            }
        }
        return reducible.size();
    }
}
}