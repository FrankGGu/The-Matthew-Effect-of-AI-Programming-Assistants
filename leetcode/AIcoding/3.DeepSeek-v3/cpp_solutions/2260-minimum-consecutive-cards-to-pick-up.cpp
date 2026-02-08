class Solution {
public:
    int minimumCardPickup(vector<int>& cards) {
        unordered_map<int, int> lastIndex;
        int minDistance = INT_MAX;

        for (int i = 0; i < cards.size(); ++i) {
            if (lastIndex.find(cards[i]) != lastIndex.end()) {
                minDistance = min(minDistance, i - lastIndex[cards[i]] + 1);
            }
            lastIndex[cards[i]] = i;
        }

        return minDistance == INT_MAX ? -1 : minDistance;
    }
};