#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minimumRounds(vector<int>& tasks) {
        unordered_map<int, int> freq;
        for (int task : tasks) {
            freq[task]++;
        }

        int rounds = 0;
        for (auto const& [key, val] : freq) {
            if (val == 1) {
                return -1;
            } else if (val % 3 == 0) {
                rounds += val / 3;
            } else if (val % 3 == 1) {
                rounds += (val - 4) / 3 + 2;
            } else {
                rounds += val / 3 + 1;
            }
        }

        return rounds;
    }
};