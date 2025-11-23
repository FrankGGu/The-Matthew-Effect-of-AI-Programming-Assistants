#include <vector>
#include <unordered_map>
#include <algorithm>
#include <climits>

class Solution {
public:
    int minimumCardPickup(std::vector<int>& cards) {
        std::unordered_map<int, int> last_index;
        int min_length = INT_MAX;

        for (int i = 0; i < cards.size(); ++i) {
            if (last_index.count(cards[i])) {
                min_length = std::min(min_length, i - last_index[cards[i]] + 1);
            }
            last_index[cards[i]] = i;
        }

        return (min_length == INT_MAX) ? -1 : min_length;
    }
};