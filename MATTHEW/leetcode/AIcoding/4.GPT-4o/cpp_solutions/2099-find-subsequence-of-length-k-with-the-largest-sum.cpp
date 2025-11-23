#include <vector>
#include <algorithm>

using namespace std;

vector<int> maxSubsequence(vector<int>& nums, int k) {
    vector<pair<int, int>> numIndex;
    for (int i = 0; i < nums.size(); i++) {
        numIndex.push_back({nums[i], i});
    }
    sort(numIndex.rbegin(), numIndex.rend());
    vector<int> result;
    for (int i = 0; i < k; i++) {
        result.push_back(numIndex[i].first);
    }
    sort(result.begin(), result.end(), [&](int a, int b) {
        return find(nums.begin(), nums.end(), a) < find(nums.begin(), nums.end(), b);
    });
    return result;
}