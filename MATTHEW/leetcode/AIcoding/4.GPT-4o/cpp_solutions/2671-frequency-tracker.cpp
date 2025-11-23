class FrequencyTracker {
public:
    unordered_map<int, int> freq;
    unordered_map<int, int> count;

    FrequencyTracker() {}

    void add(int number) {
        if (freq[number]) {
            count[freq[number]]--;
            if (count[freq[number]] == 0) {
                count.erase(freq[number]);
            }
        }
        freq[number]++;
        count[freq[number]]++;
    }

    void deleteOne(int number) {
        if (freq[number]) {
            count[freq[number]]--;
            if (count[freq[number]] == 0) {
                count.erase(freq[number]);
            }
            freq[number]--;
            if (freq[number] > 0) {
                count[freq[number]]++;
            }
        }
    }

    bool hasFrequency(int frequency) {
        return count.find(frequency) != count.end();
    }
};