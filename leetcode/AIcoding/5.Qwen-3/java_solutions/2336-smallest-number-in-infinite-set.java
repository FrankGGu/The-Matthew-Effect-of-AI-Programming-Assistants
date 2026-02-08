public class Solution {

import java.util.*;

public class SmallestInfiniteSet {
    private int current;
    private PriorityQueue<Integer> heap;
    private Set<Integer> added;

    public SmallestInfiniteSet() {
        current = 1;
        heap = new PriorityQueue<>();
        added = new HashSet<>();
    }

    public int popSmallest() {
        if (!heap.isEmpty()) {
            int val = heap.poll();
            added.remove(val);
            return val;
        } else {
            int val = current;
            current++;
            return val;
        }
    }

    public void addBack(int num) {
        if (num < current && !added.contains(num)) {
            heap.add(num);
            added.add(num);
        }
    }
}
}