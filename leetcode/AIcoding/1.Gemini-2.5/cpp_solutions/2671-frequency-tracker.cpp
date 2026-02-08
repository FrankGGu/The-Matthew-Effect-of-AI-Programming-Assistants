#include <unordered_map>

class FrequencyTracker {
private:
    std::unordered_map<int, int> num_to_freq; // Stores number -> its current frequency
    std::unordered_map<int, int> freq_to_count; // Stores frequency -> count of numbers that have this frequency

public:
    FrequencyTracker() {
        // No specific initialization needed for unordered_maps
    }

    void add(int number) {
        int old_freq = num_to_freq[number]; // Accessing might insert with 0 if not present

        if (old_freq > 0) {
            freq_to_count[old_freq]--;
        }

        num_to_freq[number]++;
        int new_freq = num_to_freq[number];

        freq_to_count[new_freq]++;
    }

    void deleteOne(int number) {
        // Check if number exists and has a frequency > 0
        if (num_to_freq.count(number) == 0 || num_to_freq[number] == 0) {
            return; // Number not present or frequency is already 0
        }

        int old_freq = num_to_freq[number];

        freq_to_count[old_freq]--;

        num_to_freq[number]--;
        int new_freq = num_to_freq[number];

        if (new_freq > 0) { // Only update freq_to_count if the number still has occurrences
            freq_to_count[new_freq]++;
        }
    }

    bool hasFrequency(int frequency) {
        return freq_to_count.count(frequency) && freq_to_count[frequency] > 0;
    }
};