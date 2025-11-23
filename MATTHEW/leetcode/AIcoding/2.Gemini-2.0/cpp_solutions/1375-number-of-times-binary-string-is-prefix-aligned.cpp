#include <vector>

using namespace std;

class Solution {
public:
    int numTimesAllBlue(vector<int>& flips) {
        int n = flips.size();
        int rightmost = 0;
        int count = 0;
        for (int i = 0; i < n; ++i) {
            rightmost = max(rightmost, flips[i]);
            if (rightmost == i + 1) {
                count++;
            }
        }
        return count;
    }
};