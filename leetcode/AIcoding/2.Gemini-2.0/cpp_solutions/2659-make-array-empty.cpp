#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long countOperationsToEmptyArray(vector<int>& nums) {
        int n = nums.size();
        vector<pair<int, int>> arr(n);
        for (int i = 0; i < n; ++i) {
            arr[i] = {nums[i], i};
        }
        sort(arr.begin(), arr.end());

        vector<int> pos(n);
        for (int i = 0; i < n; ++i) {
            pos[i] = arr[i].second;
        }

        long long ans = n;
        for (int i = 1; i < n; ++i) {
            if (pos[i] < pos[i - 1]) {
                ans += (n - i);
            }
        }

        return ans;
    }
};