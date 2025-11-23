#include <unordered_map>

class FrequencyTracker {
private:
    std::unordered_map<int, int> num_freq;
    std::unordered_map<int, int> freq_count;

public:
    FrequencyTracker() {
        num_freq.clear();
        freq_count.clear();
    }

    void add(int number) {
        if (num_freq.count(number)) {
            int old_freq = num_freq[number];
            freq_count[old_freq]--;
            if (freq_count[old_freq] == 0) {
                freq_count.erase(old_freq);
            }
            num_freq[number]++;
            freq_count[num_freq[number]]++;
        } else {
            num_freq[number] = 1;
            freq_count[1]++;
        }
    }

    void deleteOne(int number) {
        if (num_freq.count(number)) {
            int old_freq = num_freq[number];
            freq_count[old_freq]--;
            if (freq_count[old_freq] == 0) {
                freq_count.erase(old_freq);
            }

            if (old_freq == 1) {
                num_freq.erase(number);
            } else {
                num_freq[number]--;
                freq_count[num_freq[number]]++;
            }
        }
    }

    bool hasFrequency(int frequency) {
        return freq_count.count(frequency);
    }
};