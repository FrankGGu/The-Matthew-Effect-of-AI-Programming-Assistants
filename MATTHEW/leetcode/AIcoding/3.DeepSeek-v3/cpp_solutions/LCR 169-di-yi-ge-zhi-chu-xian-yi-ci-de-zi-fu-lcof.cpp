#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int dismantlingAction(string arrange) {
        vector<int> charIndex(128, -1);
        int left = 0;
        int maxLen = 0;
        for (int right = 0; right < arrange.size(); right++) {
            if (charIndex[arrange[right]] >= left) {
                left = charIndex[arrange[right]] + 1;
            }
            charIndex[arrange[right]] = right;
            maxLen = max(maxLen, right - left + 1);
        }
        return maxLen;
    }
};