#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    string bestHand(vector<int>& ranks, vector<char>& suits) {
        bool flush = true;
        for (int i = 1; i < suits.size(); ++i) {
            if (suits[i] != suits[0]) {
                flush = false;
                break;
            }
        }
        if (flush) {
            return "Flush";
        }

        unordered_map<int, int> rankCount;
        for (int rank : ranks) {
            rankCount[rank]++;
        }

        bool three = false;
        bool pair = false;
        for (auto& [rank, count] : rankCount) {
            if (count >= 3) {
                three = true;
                break;
            } else if (count == 2) {
                pair = true;
            }
        }

        if (three) {
            return "Three of a Kind";
        } else if (pair) {
            return "Pair";
        } else {
            return "High Card";
        }
    }
};