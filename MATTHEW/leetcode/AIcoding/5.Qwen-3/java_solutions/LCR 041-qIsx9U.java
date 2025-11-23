public class Solution {

import java.util.LinkedList;
import java.util.Queue;

public class MovingAverage {
    private final int size;
    private final Queue<Integer> queue;
    private double currentSum;

    public MovingAverage(int size) {
        this.size = size;
        this.queue = new LinkedList<>();
        this.currentSum = 0.0;
    }

    public double next(int val) {
        if (queue.size() == size) {
            currentSum -= queue.poll();
        }
        queue.offer(val);
        currentSum += val;
        return currentSum / queue.size();
    }
}
}