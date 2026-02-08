public class Solution {

import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;

public class LFUCache {
    private int capacity;
    private int minFreq;
    private Map<Integer, Integer> keyToValue;
    private Map<Integer, Integer> keyToFreq;
    private Map<Integer, PriorityQueue<Integer>> freqToKeys;

    public LFUCache(int capacity) {
        this.capacity = capacity;
        this.minFreq = 0;
        this.keyToValue = new HashMap<>();
        this.keyToFreq = new HashMap<>();
        this.freqToKeys = new HashMap<>();
    }

    public int get(int key) {
        if (!keyToValue.containsKey(key)) {
            return -1;
        }
        int value = keyToValue.get(key);
        int freq = keyToFreq.get(key);
        freqToKeys.get(freq).remove(key);
        if (freqToKeys.get(freq).isEmpty()) {
            freqToKeys.remove(freq);
            if (minFreq == freq) {
                minFreq++;
            }
        }
        freq++;
        keyToFreq.put(key, freq);
        if (!freqToKeys.containsKey(freq)) {
            freqToKeys.put(freq, new PriorityQueue<>());
        }
        freqToKeys.get(freq).add(key);
        return value;
    }

    public void put(int key, int value) {
        if (capacity == 0) {
            return;
        }
        if (keyToValue.containsKey(key)) {
            keyToValue.put(key, value);
            int freq = keyToFreq.get(key);
            freqToKeys.get(freq).remove(key);
            if (freqToKeys.get(freq).isEmpty()) {
                freqToKeys.remove(freq);
                if (minFreq == freq) {
                    minFreq++;
                }
            }
            freq++;
            keyToFreq.put(key, freq);
            if (!freqToKeys.containsKey(freq)) {
                freqToKeys.put(freq, new PriorityQueue<>());
            }
            freqToKeys.get(freq).add(key);
        } else {
            if (keyToValue.size() >= capacity) {
                int evictKey = freqToKeys.get(minFreq).poll();
                keyToValue.remove(evictKey);
                keyToFreq.remove(evictKey);
                if (freqToKeys.get(minFreq).isEmpty()) {
                    freqToKeys.remove(minFreq);
                }
            }
            keyToValue.put(key, value);
            keyToFreq.put(key, 1);
            if (!freqToKeys.containsKey(1)) {
                freqToKeys.put(1, new PriorityQueue<>());
            }
            freqToKeys.get(1).add(key);
            minFreq = 1;
        }
    }
}
}