#include <string>
#include <vector>

class Solution {
public:
    int numberOfWays(std::string corridor) {
        std::vector<int> seat_indices;
        for (int i = 0; i < corridor.length(); ++i) {
            if (corridor[i] == 'S') {
                seat_indices.push_back(i);
            }
        }

        if (seat_indices.size() == 0 || seat_indices.size() % 2 != 0) {
            return 0;
        }

        long long ans = 1;
        long long MOD = 1e9 + 7;

        for (int j = 0; j < seat_indices.size() / 2 - 1; ++j) {
            long long ways_for_this_cut = seat_indices[2 * j + 2] - seat_indices[2 * j + 1];
            ans = (ans * ways_for_this_cut) % MOD;
        }

        return static_cast<int>(ans);
    }
};