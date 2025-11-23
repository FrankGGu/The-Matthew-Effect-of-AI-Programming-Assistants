#include <vector>
#include <unordered_map>
#include <algorithm>
using namespace std;

class Solution {
public:
    int minimumCardPickup(vector<int>& cards) {
        unordered_map<int, int> cardIndex;
        int minLength = INT_MAX;

        for (int i = 0; i < cards.size(); ++i) {
            if (cardIndex.count(cards[i])) {
                minLength = min(minLength, i - cardIndex[cards[i]] + 1);
            }
            cardIndex[cards[i]] = i;
        }

        return minLength == INT_MAX ? -1 : minLength;
    }
};