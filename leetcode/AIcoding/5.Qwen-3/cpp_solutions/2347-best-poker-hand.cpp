#include <iostream>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    string bestHand(vector<int>& ranks, vector<char>& suits) {
        map<int, int> rankCount;
        for (int rank : ranks) {
            rankCount[rank]++;
        }

        bool isFlush = true;
        for (int i = 1; i < 5; ++i) {
            if (suits[i] != suits[0]) {
                isFlush = false;
                break;
            }
        }

        if (isFlush) {
            return "Flush";
        }

        int maxCount = 0;
        for (auto& pair : rankCount) {
            maxCount = max(maxCount, pair.second);
        }

        if (maxCount >= 4) {
            return "Four of a Kind";
        } else if (maxCount == 3) {
            return "Three of a Kind";
        } else if (maxCount == 2) {
            return "Pair";
        } else {
            return "High Card";
        }
    }
};