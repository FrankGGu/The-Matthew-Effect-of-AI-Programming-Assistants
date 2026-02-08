import java.util.LinkedList;
import java.util.Queue;

class MovingAverage {
    private Queue<Integer> window;
    private int size;
    private double currentSum;

    public MovingAverage(int size) {
        this.size = size;
        this.window = new LinkedList<>();
        this.currentSum = 0;
    }

    public double next(int val) {
        window.offer(val);
        currentSum += val;

        if (window.size() > size) {
            currentSum -= window.poll();
        }

        return currentSum / window.size();
    }
}