#include <vector>
#include <algorithm>

class Solution {
public:
    int maxChunksToSorted(std::vector<int>& arr) {
        int chunks = 0;
        int current_max = 0;

        for (int i = 0; i < arr.size(); ++i) {
            current_max = std::max(current_max, arr[i]);
            if (current_max == i) {
                chunks++;
            }
        }
        return chunks;
    }
};