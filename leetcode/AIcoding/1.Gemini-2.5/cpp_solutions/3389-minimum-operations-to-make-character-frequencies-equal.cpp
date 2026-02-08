#include <string>
#include <vector>
#include <algorithm>
#include <set>

class Solution {
public:
    int minDeletions(std::string s) {
        std::vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        std::vector<int> actual_freqs;
        for (int f : freq) {
            if (f > 0) {
                actual_freqs.push_back(f);
            }
        }
        std::sort(actual_freqs.rbegin(), actual_freqs.rend());

        int operations = 0;
        std::set<int> used_freqs;

        for (int current_f : actual_freqs) {
            while (current_f > 0 && used_freqs.count(current_f)) {
                current_f--;
                operations++;
            }
            if (current_f > 0) {
                used_freqs.insert(current_f);
            }
        }

        return operations;
    }
};