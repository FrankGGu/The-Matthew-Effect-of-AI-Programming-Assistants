import java.util.HashMap;
import java.util.LinkedHashSet;

class LFUCache {

    private final int capacity;
    private int size;
    private int minFreq;
    private final HashMap<Integer, Integer> keyToVal;
    private final HashMap<Integer, Integer> keyToFreq;
    private final HashMap<Integer, LinkedHashSet<Integer>> freqToKeys;

    public LFUCache(int capacity) {
        this.capacity = capacity;
        this.size = 0;
        this.minFreq = 0;
        this.keyToVal = new HashMap<>();
        this.keyToFreq = new HashMap<>();
        this.freqToKeys = new HashMap<>();
    }

    public int get(int key) {
        if (!keyToVal.containsKey(key)) {
            return -1;
        }

        increaseFreq(key);
        return keyToVal.get(key);
    }

    public void put(int key, int value) {
        if (capacity <= 0) {
            return;
        }

        if (keyToVal.containsKey(key)) {
            keyToVal.put(key, value);
            increaseFreq(key);
            return;
        }

        if (size == capacity) {
            removeMinFreqKey();
        }

        keyToVal.put(key, value);
        keyToFreq.put(key, 1);
        freqToKeys.putIfAbsent(1, new LinkedHashSet<>());
        freqToKeys.get(1).add(key);
        minFreq = 1;
        size++;
    }

    private void increaseFreq(int key) {
        int freq = keyToFreq.get(key);
        keyToFreq.put(key, freq + 1);

        freqToKeys.get(freq).remove(key);
        if (freqToKeys.get(freq).isEmpty()) {
            freqToKeys.remove(freq);
            if (minFreq == freq) {
                minFreq++;
            }
        }

        freqToKeys.putIfAbsent(freq + 1, new LinkedHashSet<>());
        freqToKeys.get(freq + 1).add(key);
    }

    private void removeMinFreqKey() {
        int keyToRemove = freqToKeys.get(minFreq).iterator().next();
        freqToKeys.get(minFreq).remove(keyToRemove);
        if (freqToKeys.get(minFreq).isEmpty()) {
            freqToKeys.remove(minFreq);
        }

        keyToVal.remove(keyToRemove);
        keyToFreq.remove(keyToRemove);
        size--;
    }
}