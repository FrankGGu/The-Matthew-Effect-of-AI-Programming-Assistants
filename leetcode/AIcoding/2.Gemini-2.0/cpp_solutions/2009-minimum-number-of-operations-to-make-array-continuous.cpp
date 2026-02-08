#include <vector>
#include <algorithm>
#include <set>

using namespace std;

int minOperations(vector<int>& nums) {
    int n = nums.size();
    set<int> s(nums.begin(), nums.end());
    vector<int> uniqueNums(s.begin(), s.end());
    int m = uniqueNums.size();
    int ans = n;
    for (int i = 0; i < m; ++i) {
        int left = uniqueNums[i];
        int right = left + n - 1;
        int j = upper_bound(uniqueNums.begin(), uniqueNums.end(), right) - uniqueNums.begin();
        int count = j - i;
        ans = min(ans, n - count);
    }
    return ans;
}