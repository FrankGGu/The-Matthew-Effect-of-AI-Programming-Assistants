public class Solution {

import java.util.*;

class FreqStack {
    private Map<Integer, Integer> freqMap;
    private Map<Integer, Stack<Integer>> group;
    private int maxFreq;

    public FreqStack() {
        freqMap = new HashMap<>();
        group = new HashMap<>();
        maxFreq = 0;
    }

    public void push(int val) {
        int freq = freqMap.getOrDefault(val, 0) + 1;
        freqMap.put(val, freq);
        if (!group.containsKey(freq)) {
            group.put(freq, new Stack<>());
        }
        group.get(freq).push(val);
        if (freq > maxFreq) {
            maxFreq = freq;
        }
    }

    public int pop() {
        int val = group.get(maxFreq).pop();
        freqMap.put(val, maxFreq - 1);
        if (group.get(maxFreq).isEmpty()) {
            maxFreq--;
        }
        return val;
    }
}
}