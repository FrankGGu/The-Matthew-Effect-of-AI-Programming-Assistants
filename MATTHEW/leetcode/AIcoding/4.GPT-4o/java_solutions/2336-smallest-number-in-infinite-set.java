import java.util.HashSet;
import java.util.PriorityQueue;

class SmallestInfiniteSet {

    private PriorityQueue<Integer> minHeap;
    private HashSet<Integer> added;
    private int current;

    public SmallestInfiniteSet() {
        minHeap = new PriorityQueue<>();
        added = new HashSet<>();
        current = 1;
    }

    public int popSmallest() {
        if (!minHeap.isEmpty()) {
            return minHeap.poll();
        }
        return current++;
    }

    public void addBack(int num) {
        if (num < current && !added.contains(num)) {
            minHeap.offer(num);
            added.add(num);
        }
    }
}