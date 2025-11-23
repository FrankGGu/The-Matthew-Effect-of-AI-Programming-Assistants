#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    string bestHand(vector<int>& ranks, vector<char>& suits) {
        bool sameSuit = true;
        for (int i = 1; i < 5; ++i) {
            if (suits[i] != suits[0]) {
                sameSuit = false;
                break;
            }
        }

        if (sameSuit) {
            return "Flush";
        }

        map<int, int> rankCounts;
        for (int rank : ranks) {
            rankCounts[rank]++;
        }

        int maxCount = 0;
        for (auto const& [key, val] : rankCounts) {
            maxCount = max(maxCount, val);
        }

        if (maxCount >= 3) {
            return "Three of a Kind";
        } else if (maxCount == 2) {
            return "Pair";
        } else {
            return "High Card";
        }
    }
};