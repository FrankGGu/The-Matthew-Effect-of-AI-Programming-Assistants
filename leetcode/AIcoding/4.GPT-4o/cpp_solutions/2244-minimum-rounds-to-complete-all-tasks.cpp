#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int minimumRounds(std::vector<int>& tasks) {
        std::unordered_map<int, int> freq;
        for (int task : tasks) {
            freq[task]++;
        }

        int rounds = 0;
        for (const auto& [task, count] : freq) {
            if (count == 1) return -1;
            rounds += (count + 2) / 3;
        }

        return rounds;
    }
};