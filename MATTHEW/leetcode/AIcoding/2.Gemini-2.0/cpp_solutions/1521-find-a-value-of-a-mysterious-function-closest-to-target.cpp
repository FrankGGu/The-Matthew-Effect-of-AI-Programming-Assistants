#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int closestToTarget(vector<int>& arr, int target) {
        int res = INT_MAX;
        vector<int> possible;
        for (int a : arr) {
            vector<int> nextPossible;
            nextPossible.push_back(a);
            for (int p : possible) {
                nextPossible.push_back(a & p);
            }
            sort(nextPossible.begin(), nextPossible.end());
            nextPossible.erase(unique(nextPossible.begin(), nextPossible.end()), nextPossible.end());
            for (int p : nextPossible) {
                res = min(res, abs(p - target));
            }
            possible = nextPossible;
        }
        return res;
    }
};