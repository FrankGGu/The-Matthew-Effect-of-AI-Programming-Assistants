import java.util.*;

class LFUCache {
    private final Map<Integer, Integer> values;
    private final Map<Integer, Integer> frequencies;
    private final TreeMap<Integer, Queue<Integer>> frequencyList;
    private final int capacity;
    private int minFreq;

    public LFUCache(int capacity) {
        this.capacity = capacity;
        this.values = new HashMap<>();
        this.frequencies = new HashMap<>();
        this.frequencyList = new TreeMap<>();
        this.minFreq = 0;
    }

    public int get(int key) {
        if (!values.containsKey(key)) return -1;
        int freq = frequencies.get(key);
        frequencies.put(key, freq + 1);
        frequencyList.get(freq).remove(key);
        if (frequencyList.get(freq).isEmpty()) {
            frequencyList.remove(freq);
            if (minFreq == freq) minFreq++;
        }
        frequencyList.computeIfAbsent(freq + 1, k -> new LinkedList<>()).offer(key);
        return values.get(key);
    }

    public void put(int key, int value) {
        if (capacity == 0) return;
        if (values.containsKey(key)) {
            values.put(key, value);
            get(key);
            return;
        }
        if (values.size() == capacity) {
            int evictKey = frequencyList.firstEntry().getValue().poll();
            if (frequencyList.firstEntry().getValue().isEmpty()) {
                frequencyList.remove(frequencyList.firstKey());
                minFreq++;
            }
            values.remove(evictKey);
            frequencies.remove(evictKey);
        }
        values.put(key, value);
        frequencies.put(key, 1);
        minFreq = 1;
        frequencyList.computeIfAbsent(1, k -> new LinkedList<>()).offer(key);
    }
}