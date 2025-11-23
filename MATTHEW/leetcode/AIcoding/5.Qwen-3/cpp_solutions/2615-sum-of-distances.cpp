#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> sumDistance(vector<int>& nums, vector<int>& s) {
        int n = nums.size();
        vector<pair<int, int>> points(n);
        for (int i = 0; i < n; ++i) {
            points[i] = {nums[i], s[i]};
        }

        sort(points.begin(), points.end());

        vector<int> res(n, 0);
        vector<long long> prefix(n, 0);

        for (int i = 1; i < n; ++i) {
            prefix[i] = prefix[i - 1] + (long long)(points[i].first - points[i - 1].first) * i;
        }

        for (int i = n - 2; i >= 0; --i) {
            prefix[i] += prefix[i + 1] + (long long)(points[i + 1].first - points[i].first) * (n - i - 1);
        }

        for (int i = 0; i < n; ++i) {
            res[i] = prefix[i];
        }

        return res;
    }
};