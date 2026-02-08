import java.util.*;

class MKAverage {
    private TreeMap<Integer, Integer> lower;
    private TreeMap<Integer, Integer> middle;
    private TreeMap<Integer, Integer> upper;
    private int m;
    private int k;
    private Queue<Integer> queue;
    private int lowerSize;
    private int upperSize;
    private long sum;

    public MKAverage(int m, int k) {
        this.m = m;
        this.k = k;
        this.lower = new TreeMap<>();
        this.middle = new TreeMap<>();
        this.upper = new TreeMap<>();
        this.queue = new LinkedList<>();
        this.lowerSize = 0;
        this.upperSize = 0;
        this.sum = 0;
    }

    public void addElement(int num) {
        if (queue.size() == m) {
            int removed = queue.poll();
            if (lower.containsKey(removed)) {
                remove(lower, removed);
                lowerSize--;
            } else if (upper.containsKey(removed)) {
                remove(upper, removed);
                upperSize--;
            } else {
                remove(middle, removed);
                sum -= removed;
            }
        }
        queue.offer(num);
        add(middle, num);
        sum += num;
        while (lowerSize < k && !middle.isEmpty()) {
            int first = middle.firstKey();
            remove(middle, first);
            sum -= first;
            add(lower, first);
            lowerSize++;
        }
        while (!middle.isEmpty() && !lower.isEmpty() && middle.firstKey() < lower.lastKey()) {
            int middleFirst = middle.firstKey();
            remove(middle, middleFirst);
            sum -= middleFirst;
            add(lower, middleFirst);
            int lowerLast = lower.lastKey();
            remove(lower, lowerLast);
            add(middle, lowerLast);
            sum += lowerLast;
        }
        while (upperSize < k && !middle.isEmpty()) {
            int last = middle.lastKey();
            remove(middle, last);
            sum -= last;
            add(upper, last);
            upperSize++;
        }
        while (!middle.isEmpty() && !upper.isEmpty() && middle.lastKey() > upper.firstKey()) {
            int middleLast = middle.lastKey();
            remove(middle, middleLast);
            sum -= middleLast;
            add(upper, middleLast);
            int upperFirst = upper.firstKey();
            remove(upper, upperFirst);
            add(middle, upperFirst);
            sum += upperFirst;
        }
    }

    public int calculateMKAverage() {
        if (queue.size() < m) {
            return -1;
        }
        return (int) (sum / (m - 2 * k));
    }

    private void add(TreeMap<Integer, Integer> map, int num) {
        map.put(num, map.getOrDefault(num, 0) + 1);
    }

    private void remove(TreeMap<Integer, Integer> map, int num) {
        int count = map.get(num);
        if (count == 1) {
            map.remove(num);
        } else {
            map.put(num, count - 1);
        }
    }
}