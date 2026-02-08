class FrequencyTracker {
private:
    unordered_map<int, int> numToFreq;
    unordered_map<int, int> freqToCount;

public:
    FrequencyTracker() {

    }

    void add(int number) {
        int oldFreq = numToFreq[number];
        if (oldFreq > 0) {
            freqToCount[oldFreq]--;
        }
        numToFreq[number]++;
        freqToCount[numToFreq[number]]++;
    }

    void deleteOne(int number) {
        if (numToFreq.find(number) == numToFreq.end() || numToFreq[number] == 0) {
            return;
        }
        int oldFreq = numToFreq[number];
        freqToCount[oldFreq]--;
        numToFreq[number]--;
        if (numToFreq[number] > 0) {
            freqToCount[numToFreq[number]]++;
        }
    }

    bool hasFrequency(int frequency) {
        return freqToCount[frequency] > 0;
    }
};