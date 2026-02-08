import java.util.HashMap;
import java.util.Map;

class FrequencyTracker {

    private Map<Integer, Integer> numCounts;
    private Map<Integer, Integer> freqCounts;

    public FrequencyTracker() {
        numCounts = new HashMap<>();
        freqCounts = new HashMap<>();
    }

    public void add(int number) {
        int oldFreq = numCounts.getOrDefault(number, 0);
        if (oldFreq > 0) {
            decrementFreqCount(oldFreq);
        }

        int newFreq = oldFreq + 1;
        numCounts.put(number, newFreq);
        incrementFreqCount(newFreq);
    }

    public void deleteOne(int number) {
        int oldFreq = numCounts.getOrDefault(number, 0);
        if (oldFreq == 0) {
            return;
        }

        decrementFreqCount(oldFreq);

        int newFreq = oldFreq - 1;
        if (newFreq == 0) {
            numCounts.remove(number);
        } else {
            numCounts.put(number, newFreq);
        }

        if (newFreq > 0) {
            incrementFreqCount(newFreq);
        }
    }

    public boolean hasFrequency(int frequency) {
        return freqCounts.getOrDefault(frequency, 0) > 0;
    }

    private void incrementFreqCount(int frequency) {
        freqCounts.put(frequency, freqCounts.getOrDefault(frequency, 0) + 1);
    }

    private void decrementFreqCount(int frequency) {
        freqCounts.put(frequency, freqCounts.get(frequency) - 1);
        if (freqCounts.get(frequency) == 0) {
            freqCounts.remove(frequency);
        }
    }
}