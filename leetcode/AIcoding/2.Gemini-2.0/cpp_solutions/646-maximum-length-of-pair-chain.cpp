#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findLongestChain(vector<vector<int>>& pairs) {
        sort(pairs.begin(), pairs.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        int current_end = INT_MIN;
        int count = 0;

        for (const auto& pair : pairs) {
            if (pair[0] > current_end) {
                count++;
                current_end = pair[1];
            }
        }

        return count;
    }
};