import java.util.*;

class SmallestInfiniteSet {
    private PriorityQueue<Integer> minHeap;
    private Set<Integer> set;
    private int current;

    public SmallestInfiniteSet() {
        minHeap = new PriorityQueue<>();
        set = new HashSet<>();
        current = 1;
    }

    public int popSmallest() {
        if (!minHeap.isEmpty()) {
            int smallest = minHeap.poll();
            set.remove(smallest);
            return smallest;
        } else {
            return current++;
        }
    }

    public void addBack(int num) {
        if (num < current && !set.contains(num)) {
            minHeap.offer(num);
            set.add(num);
        }
    }
}