#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int runeReserve(vector<int>& runes) {
        if (runes.empty()) return 0;
        sort(runes.begin(), runes.end());
        int max_count = 1;
        int current_count = 1;
        for (int i = 1; i < runes.size(); ++i) {
            if (runes[i] - runes[i-1] <= 1) {
                current_count++;
                max_count = max(max_count, current_count);
            } else {
                current_count = 1;
            }
        }
        return max_count;
    }
};