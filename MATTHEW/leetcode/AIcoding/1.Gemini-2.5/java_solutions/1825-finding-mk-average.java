import java.util.LinkedList;
import java.util.TreeMap;

class MKAverage {
    private int m;
    private int k;
    private LinkedList<Integer> window;

    private TreeMap<Integer, Integer> left;
    private TreeMap<Integer, Integer> mid;
    private TreeMap<Integer, Integer> right;

    private long leftSum;
    private long midSum;
    private long rightSum;
    private int leftSize;
    private int midSize;
    private int rightSize;

    public MKAverage(int m, int k) {
        this.m = m;
        this.k = k;
        this.window = new LinkedList<>();

        this.left = new TreeMap<>();
        this.mid = new TreeMap<>();
        this.right = new TreeMap<>();

        this.leftSum = 0;
        this.midSum = 0;
        this.rightSum = 0;
        this.leftSize = 0;
        this.midSize = 0;
        this.rightSize = 0;
    }

    private void addToMap(TreeMap<Integer, Integer> map, int val) {
        map.put(val, map.getOrDefault(val, 0) + 1);
        if (map == left) {
            leftSum += val;
            leftSize++;
        } else if (map == mid) {
            midSum += val;
            midSize++;
        } else {
            rightSum += val;
            rightSize++;
        }
    }

    private void removeFromMap(TreeMap<Integer, Integer> map, int val) {
        map.put(val, map.get(val) - 1);
        if (map.get(val) == 0) {
            map.remove(val);
        }
        if (map == left) {
            leftSum -= val;
            leftSize--;
        } else if (map == mid) {
            midSum -= val;
            midSize--;
        } else {
            rightSum -= val;
            rightSize--;
        }
    }

    private void moveFromTo(TreeMap<Integer, Integer> src, TreeMap<Integer, Integer> dest, int val) {
        removeFromMap(src, val);
        addToMap(dest, val);
    }

    private void rebalance() {
        while (leftSize > k) {
            moveFromTo(left, mid, left.lastKey());
        }
        while (rightSize > k) {
            moveFromTo(right, mid, right.firstKey());
        }
        while (leftSize < k && midSize > 0) {
            moveFromTo(mid, left, mid.firstKey());
        }
        while (rightSize < k && midSize > 0) {
            moveFromTo(mid, right, mid.lastKey());
        }
    }

    public void addElement(int num) {
        window.addLast(num);

        if (left.isEmpty() || num <= left.lastKey()) {
            addToMap(left, num);
        } else if (right.isEmpty() || num >= right.firstKey()) {
            addToMap(right, num);
        } else {
            addToMap(mid, num);
        }

        rebalance();

        if (window.size() > m) {
            int oldNum = window.removeFirst();

            if (left.containsKey(oldNum)) {
                removeFromMap(left, oldNum);
            } else if (mid.containsKey(oldNum)) {
                removeFromMap(mid, oldNum);
            } else {
                removeFromMap(right, oldNum);
            }

            rebalance();
        }
    }

    public int calculateMKAverage() {
        if (window.size() < m) {
            return -1;
        }
        return (int) (midSum / midSize);
    }
}