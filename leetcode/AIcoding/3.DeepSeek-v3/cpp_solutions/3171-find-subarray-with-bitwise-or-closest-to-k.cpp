#include <vector>
#include <climits>
#include <algorithm>

using namespace std;

class Solution {
public:
    int closestToTarget(vector<int>& arr, int target) {
        int n = arr.size();
        int min_diff = INT_MAX;
        vector<int> unique_or;

        for (int num : arr) {
            vector<int> temp;
            temp.push_back(num);
            for (int val : unique_or) {
                temp.push_back(val | num);
            }
            unique_or.clear();
            sort(temp.begin(), temp.end());
            temp.erase(unique(temp.begin(), temp.end()), temp.end());
            for (int val : temp) {
                min_diff = min(min_diff, abs(val - target));
                unique_or.push_back(val);
            }
            if (min_diff == 0) break;
        }

        return min_diff;
    }
};