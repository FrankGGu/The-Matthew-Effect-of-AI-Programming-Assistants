#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int findTheWinner(int n, int k) {
        vector<int> players;
        for (int i = 1; i <= n; ++i) {
            players.push_back(i);
        }

        int current = 0;
        while (players.size() > 1) {
            current = (current + k - 1) % players.size();
            players.erase(players.begin() + current);
        }

        return players[0];
    }
};