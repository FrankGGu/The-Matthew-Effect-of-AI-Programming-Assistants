public class Solution {

import java.util.*;

public class MKAverage {
    private int m;
    private int k;
    private Deque<Integer> queue;
    private List<Integer> list;
    private PriorityQueue<Integer> minHeap;
    private PriorityQueue<Integer> maxHeap;
    private int size;

    public MKAverage(int m, int k) {
        this.m = m;
        this.k = k;
        this.queue = new ArrayDeque<>();
        this.list = new ArrayList<>();
        this.minHeap = new PriorityQueue<>();
        this.maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        this.size = 0;
    }

    public void addElement(int num) {
        queue.addLast(num);
        list.add(num);
        size++;

        if (size > m) {
            int removed = queue.removeFirst();
            list.remove((Integer) removed);
        }

        if (size >= m) {
            for (int i = 0; i < k; i++) {
                if (maxHeap.size() < k) {
                    maxHeap.add(list.get(i));
                } else if (list.get(i) < maxHeap.peek()) {
                    maxHeap.add(list.get(i));
                }
            }

            for (int i = list.size() - k; i < list.size(); i++) {
                if (minHeap.size() < k) {
                    minHeap.add(list.get(i));
                } else if (list.get(i) > minHeap.peek()) {
                    minHeap.add(list.get(i));
                }
            }

            while (maxHeap.size() > k) {
                minHeap.add(maxHeap.poll());
            }

            while (minHeap.size() > k) {
                maxHeap.add(minHeap.poll());
            }

            int sum = 0;
            for (int i = k; i < list.size() - k; i++) {
                sum += list.get(i);
            }
            int avg = sum / (list.size() - 2 * k);
            System.out.println(avg);
        }
    }

    public int getMKAverage() {
        if (size < m) {
            return -1;
        }
        int sum = 0;
        for (int i = k; i < list.size() - k; i++) {
            sum += list.get(i);
        }
        return sum / (list.size() - 2 * k);
    }
}
}