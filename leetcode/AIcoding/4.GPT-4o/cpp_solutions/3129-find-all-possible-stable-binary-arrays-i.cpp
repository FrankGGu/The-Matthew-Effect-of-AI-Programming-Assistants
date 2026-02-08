#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<vector<int>> findStableArrays(int n, vector<int>& allowedSwaps) {
        vector<vector<int>> result;
        vector<int> currArray(n);
        for (int i = 0; i < n; ++i) {
            currArray[i] = i;
        }
        unordered_set<int> swapSet(allowedSwaps.begin(), allowedSwaps.end());
        generate(currArray, result, swapSet, n, 0);
        return result;
    }

private:
    void generate(vector<int>& currArray, vector<vector<int>>& result, unordered_set<int>& swapSet, int n, int index) {
        if (index == n) {
            result.push_back(currArray);
            return;
        }
        generate(currArray, result, swapSet, n, index + 1);
        for (int i = index + 1; i < n; ++i) {
            if (swapSet.count(index * n + i)) {
                swap(currArray[index], currArray[i]);
                generate(currArray, result, swapSet, n, index + 1);
                swap(currArray[index], currArray[i]);
            }
        }
    }
};