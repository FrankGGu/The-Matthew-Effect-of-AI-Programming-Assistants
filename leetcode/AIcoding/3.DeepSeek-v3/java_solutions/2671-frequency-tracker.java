class FrequencyTracker {
    private Map<Integer, Integer> numToFreq;
    private Map<Integer, Integer> freqToCount;

    public FrequencyTracker() {
        numToFreq = new HashMap<>();
        freqToCount = new HashMap<>();
    }

    public void add(int number) {
        int oldFreq = numToFreq.getOrDefault(number, 0);
        numToFreq.put(number, oldFreq + 1);

        freqToCount.put(oldFreq, freqToCount.getOrDefault(oldFreq, 0) - 1);
        freqToCount.put(oldFreq + 1, freqToCount.getOrDefault(oldFreq + 1, 0) + 1);
    }

    public void deleteOne(int number) {
        if (!numToFreq.containsKey(number) || numToFreq.get(number) == 0) {
            return;
        }

        int oldFreq = numToFreq.get(number);
        numToFreq.put(number, oldFreq - 1);

        freqToCount.put(oldFreq, freqToCount.getOrDefault(oldFreq, 0) - 1);
        freqToCount.put(oldFreq - 1, freqToCount.getOrDefault(oldFreq - 1, 0) + 1);
    }

    public boolean hasFrequency(int frequency) {
        return freqToCount.getOrDefault(frequency, 0) > 0;
    }
}