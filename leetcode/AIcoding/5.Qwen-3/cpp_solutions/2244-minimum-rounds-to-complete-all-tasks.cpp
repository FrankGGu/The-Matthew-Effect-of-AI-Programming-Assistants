#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minimumRounds(vector<int>& tasks) {
        unordered_map<int, int> count;
        for (int task : tasks) {
            count[task]++;
        }

        int rounds = 0;
        for (auto& [priority, freq] : count) {
            if (freq == 1) {
                return -1;
            }
            rounds += (freq + 2) / 3;
        }
        return rounds;
    }
};