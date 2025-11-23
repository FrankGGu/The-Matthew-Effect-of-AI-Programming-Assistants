#include <vector>
#include <unordered_map>

class Solution {
public:
    int minimumRounds(std::vector<int>& tasks) {
        std::unordered_map<int, int> freq_map;
        for (int task_difficulty : tasks) {
            freq_map[task_difficulty]++;
        }

        int total_rounds = 0;
        for (auto const& pair : freq_map) {
            int count = pair.second;
            if (count == 1) {
                return -1;
            }
            total_rounds += (count + 2) / 3;
        }

        return total_rounds;
    }
};