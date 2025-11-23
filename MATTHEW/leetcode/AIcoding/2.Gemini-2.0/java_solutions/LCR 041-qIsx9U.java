class MovingAverage {

    private int size;
    private double sum;
    private Deque<Integer> deque;

    public MovingAverage(int size) {
        this.size = size;
        this.sum = 0;
        this.deque = new LinkedList<>();
    }

    public double next(int val) {
        deque.offer(val);
        sum += val;

        if (deque.size() > size) {
            sum -= deque.poll();
        }

        return sum / deque.size();
    }
}