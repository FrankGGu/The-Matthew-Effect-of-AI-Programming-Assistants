import java.util.HashMap;

class FrequencyTracker {
    private HashMap<Integer, Integer> numCount;
    private HashMap<Integer, Integer> countFreq;

    public FrequencyTracker() {
        numCount = new HashMap<>();
        countFreq = new HashMap<>();
    }

    public void add(int number) {
        int oldCount = numCount.getOrDefault(number, 0);
        numCount.put(number, oldCount + 1);
        updateCountFreq(oldCount, oldCount + 1);
    }

    public void deleteOne(int number) {
        int oldCount = numCount.getOrDefault(number, 0);
        if (oldCount > 0) {
            numCount.put(number, oldCount - 1);
            updateCountFreq(oldCount, oldCount - 1);
        }
    }

    public boolean hasFrequency(int frequency) {
        return countFreq.getOrDefault(frequency, 0) > 0;
    }

    private void updateCountFreq(int oldCount, int newCount) {
        if (oldCount > 0) {
            countFreq.put(oldCount, countFreq.getOrDefault(oldCount, 0) - 1);
            if (countFreq.get(oldCount) == 0) {
                countFreq.remove(oldCount);
            }
        }
        if (newCount > 0) {
            countFreq.put(newCount, countFreq.getOrDefault(newCount, 0) + 1);
        }
    }
}