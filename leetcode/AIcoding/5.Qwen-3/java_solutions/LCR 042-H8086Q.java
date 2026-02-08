public class Solution {

import java.util.LinkedList;
import java.util.Queue;

public class RecentCalls {
    private Queue<Integer> queue;

    public RecentCalls() {
        queue = new LinkedList<>();
    }

    public int ping(int t) {
        while (!queue.isEmpty() && t - queue.peek() > 3000) {
            queue.poll();
        }
        queue.offer(t);
        return queue.size();
    }
}
}