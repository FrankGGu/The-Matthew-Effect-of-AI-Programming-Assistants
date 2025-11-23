import java.util.*;

class FreqStack {
    private Map<Integer, Integer> freqMap;
    private Map<Integer, Stack<Integer>> groupMap;
    private int maxFreq;

    public FreqStack() {
        freqMap = new HashMap<>();
        groupMap = new HashMap<>();
        maxFreq = 0;
    }

    public void push(int val) {
        int freq = freqMap.getOrDefault(val, 0) + 1;
        freqMap.put(val, freq);
        if (freq > maxFreq) {
            maxFreq = freq;
        }
        groupMap.putIfAbsent(freq, new Stack<>());
        groupMap.get(freq).push(val);
    }

    public int pop() {
        int val = groupMap.get(maxFreq).pop();
        freqMap.put(val, freqMap.get(val) - 1);
        if (groupMap.get(maxFreq).isEmpty()) {
            maxFreq--;
        }
        return val;
    }
}