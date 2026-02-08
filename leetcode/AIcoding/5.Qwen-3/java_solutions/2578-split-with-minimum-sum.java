public class Solution {

import java.util.*;

public class Solution {
    public int splitNum(int num) {
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        while (num > 0) {
            pq.add(num % 10);
            num /= 10;
        }
        int a = 0, b = 0;
        while (!pq.isEmpty()) {
            a = a * 10 + pq.poll();
            if (!pq.isEmpty()) {
                b = b * 10 + pq.poll();
            }
        }
        return a + b;
    }
}
}