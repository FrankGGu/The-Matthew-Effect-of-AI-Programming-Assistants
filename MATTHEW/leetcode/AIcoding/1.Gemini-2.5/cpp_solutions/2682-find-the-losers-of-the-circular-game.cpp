#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<int> circularGameLosers(int n, int k) {
        std::vector<bool> received(n, false);
        int current_player_idx = 0; // 0-indexed
        int round_num = 1;

        received[current_player_idx] = true;

        while (true) {
            int steps = round_num * k;
            current_player_idx = (current_player_idx + steps) % n;

            if (received[current_player_idx]) {
                break; 
            }

            received[current_player_idx] = true;
            round_num++;
        }

        std::vector<int> losers;
        for (int i = 0; i < n; ++i) {
            if (!received[i]) {
                losers.push_back(i + 1); 
            }
        }

        return losers;
    }
};