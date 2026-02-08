#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int findTheWinner(int n, int k) {
        vector<int> players;
        for (int i = 1; i <= n; ++i) {
            players.push_back(i);
        }

        int index = 0;
        while (players.size() > 1) {
            index = (index + k - 1) % players.size();
            players.erase(players.begin() + index);
        }

        return players[0];
    }
};