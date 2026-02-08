import java.util.PriorityQueue;

class SORTracker {
    PriorityQueue<Integer> small;
    PriorityQueue<Integer> large;
    int count;

    public SORTracker() {
        small = new PriorityQueue<>((a, b) -> (b - a));
        large = new PriorityQueue<>();
        count = 0;
    }

    public void add(int score) {
        small.offer(score);
        large.offer(small.poll());
        if (large.size() > count) {
            small.offer(large.poll());
        }
    }

    public int get() {
        count++;
        return small.peek();
    }
}