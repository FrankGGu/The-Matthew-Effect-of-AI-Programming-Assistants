#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> constructBitwiseArray(vector<int>& arr) {
        int n = arr.size();
        vector<int> ans(n);
        if (n == 1) {
            ans[0] = 0;
            return ans;
        }
        ans[0] = arr[0] & arr[1];
        ans[n - 1] = arr[n - 2] & arr[n - 1];
        for (int i = 1; i < n - 1; ++i) {
            ans[i] = arr[i - 1] & arr[i] & arr[i + 1];
        }
        return ans;
    }
};