import java.util.LinkedList;
import java.util.TreeMap;

class MKAverage {
    private int m, k, count;
    private LinkedList<Integer> nums;
    private TreeMap<Integer, Integer> map;

    public MKAverage(int m, int k) {
        this.m = m;
        this.k = k;
        this.count = 0;
        this.nums = new LinkedList<>();
        this.map = new TreeMap<>();
    }

    public void addElement(int num) {
        if (count < m) {
            nums.add(num);
            map.put(num, map.getOrDefault(num, 0) + 1);
            count++;
        } else {
            int removed = nums.poll();
            map.put(removed, map.get(removed) - 1);
            if (map.get(removed) == 0) {
                map.remove(removed);
            }
            nums.add(num);
            map.put(num, map.getOrDefault(num, 0) + 1);
        }
    }

    public int calculateMKAverage() {
        if (count < m) return -1;

        int sum = 0;
        int toSkip = k;
        int toTake = m - 2 * k;
        for (Integer key : map.keySet()) {
            int freq = map.get(key);
            if (toSkip > 0) {
                if (freq <= toSkip) {
                    toSkip -= freq;
                } else {
                    freq -= toSkip;
                    toSkip = 0;
                }
            }
            if (toTake > 0) {
                int take = Math.min(freq, toTake);
                sum += take * key;
                toTake -= take;
            }
            if (toTake == 0) break;
        }

        return sum / (m - 2 * k);
    }
}