import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

class FreqStack {

    Map<Integer, Integer> freq;
    Map<Integer, Stack<Integer>> group;
    int maxFreq;

    public FreqStack() {
        freq = new HashMap<>();
        group = new HashMap<>();
        maxFreq = 0;
    }

    public void push(int val) {
        int f = freq.getOrDefault(val, 0) + 1;
        freq.put(val, f);

        maxFreq = Math.max(maxFreq, f);

        group.computeIfAbsent(f, k -> new Stack<>()).push(val);
    }

    public int pop() {
        int x = group.get(maxFreq).pop();

        freq.put(x, freq.get(x) - 1);

        if (group.get(maxFreq).isEmpty()) {
            maxFreq--;
        }

        return x;
    }
}