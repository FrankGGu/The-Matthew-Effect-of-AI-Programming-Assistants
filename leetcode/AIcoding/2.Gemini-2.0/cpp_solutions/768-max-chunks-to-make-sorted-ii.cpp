#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    int maxChunksToSorted(vector<int>& arr) {
        int n = arr.size();
        vector<int> rightMin(n + 1);
        rightMin[n] = INT_MAX;
        for (int i = n - 1; i >= 0; --i) {
            rightMin[i] = min(rightMin[i + 1], arr[i]);
        }

        int maxSoFar = INT_MIN;
        int count = 0;
        for (int i = 0; i < n; ++i) {
            maxSoFar = max(maxSoFar, arr[i]);
            if (maxSoFar <= rightMin[i + 1]) {
                count++;
            }
        }
        return count;
    }
};