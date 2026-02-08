public class Solution {

import java.util.LinkedList;
import java.util.Queue;

public class Solution {
    private Queue<Integer> queue;

    public Solution() {
        queue = new LinkedList<>();
    }

    public int ping(int t) {
        while (!queue.isEmpty() && queue.peek() < t - 3000) {
            queue.poll();
        }
        queue.offer(t);
        return queue.size();
    }
}
}