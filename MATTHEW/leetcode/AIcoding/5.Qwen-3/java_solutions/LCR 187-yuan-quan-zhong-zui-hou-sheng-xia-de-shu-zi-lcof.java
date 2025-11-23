public class Solution {

import java.util.*;

public class Solution {
    public int findTheWinner(int n, int k) {
        Queue<Integer> queue = new LinkedList<>();
        for (int i = 1; i <= n; i++) {
            queue.add(i);
        }
        while (queue.size() > 1) {
            for (int i = 0; i < k - 1; i++) {
                int num = queue.poll();
                queue.add(num);
            }
            queue.poll();
        }
        return queue.peek();
    }
}
}