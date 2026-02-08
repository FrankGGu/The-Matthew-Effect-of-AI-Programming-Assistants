public class Solution {

import java.util.*;

public class FrequencyTracker {
    private Map<Integer, Integer> numCount;
    private Map<Integer, Integer> countFreq;

    public FrequencyTracker() {
        numCount = new HashMap<>();
        countFreq = new HashMap<>();
    }

    public void add(int number) {
        int prevCount = numCount.getOrDefault(number, 0);
        if (prevCount > 0) {
            countFreq.put(prevCount, countFreq.get(prevCount) - 1);
            if (countFreq.get(prevCount) == 0) {
                countFreq.remove(prevCount);
            }
        }
        numCount.put(number, prevCount + 1);
        countFreq.put(prevCount + 1, countFreq.getOrDefault(prevCount + 1, 0) + 1);
    }

    public void deleteOne(int number) {
        int prevCount = numCount.getOrDefault(number, 0);
        if (prevCount == 0) {
            return;
        }
        countFreq.put(prevCount, countFreq.get(prevCount) - 1);
        if (countFreq.get(prevCount) == 0) {
            countFreq.remove(prevCount);
        }
        if (prevCount == 1) {
            numCount.remove(number);
        } else {
            numCount.put(number, prevCount - 1);
            countFreq.put(prevCount - 1, countFreq.getOrDefault(prevCount - 1, 0) + 1);
        }
    }

    public boolean hasFrequency(int frequency) {
        return countFreq.containsKey(frequency);
    }
}
}