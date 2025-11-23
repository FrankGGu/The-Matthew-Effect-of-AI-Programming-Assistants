#include <iostream>
#include <vector>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    int minimumConsecutiveCardsToPickUp(vector<int>& cards) {
        unordered_map<int, int> lastPos;
        int minLen = INT_MAX;
        for (int i = 0; i < cards.size(); ++i) {
            if (lastPos.find(cards[i]) != lastPos.end()) {
                minLen = min(minLen, i - lastPos[cards[i]] + 1);
            }
            lastPos[cards[i]] = i;
        }
        return minLen == INT_MAX ? -1 : minLen;
    }
};