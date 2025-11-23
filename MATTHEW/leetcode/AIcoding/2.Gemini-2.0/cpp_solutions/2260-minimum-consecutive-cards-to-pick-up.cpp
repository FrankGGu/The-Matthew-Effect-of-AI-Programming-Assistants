#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumCardPickup(vector<int>& cards) {
        unordered_map<int, int> last_seen;
        int min_length = INT_MAX;
        for (int i = 0; i < cards.size(); ++i) {
            if (last_seen.count(cards[i])) {
                min_length = min(min_length, i - last_seen[cards[i]] + 1);
            }
            last_seen[cards[i]] = i;
        }
        return min_length == INT_MAX ? -1 : min_length;
    }
};