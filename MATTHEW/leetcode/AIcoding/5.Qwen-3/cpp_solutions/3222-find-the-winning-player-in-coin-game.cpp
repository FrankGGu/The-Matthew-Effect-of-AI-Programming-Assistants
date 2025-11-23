#include <iostream>
#include <vector>

class Solution {
public:
    char findTheWinner(int n, int k) {
        std::vector<int> players(n);
        for (int i = 0; i < n; ++i) {
            players[i] = i + 1;
        }

        int current = 0;
        while (players.size() > 1) {
            current = (current + k - 1) % players.size();
            players.erase(players.begin() + current);
        }

        return static_cast<char>('A' + players[0] - 1);
    }
};