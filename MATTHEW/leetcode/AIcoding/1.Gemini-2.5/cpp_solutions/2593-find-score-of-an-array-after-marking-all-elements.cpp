#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long findScore(vector<int>& nums) {
        int n = nums.size();
        vector<pair<int, int>> arr;
        for (int i = 0; i < n; ++i) {
            arr.push_back({nums[i], i});
        }
        sort(arr.begin(), arr.end());

        vector<bool> marked(n, false);
        long long score = 0;

        for (int i = 0; i < n; ++i) {
            if (!marked[arr[i].second]) {
                score += arr[i].first;
                marked[arr[i].second] = true;

                if (arr[i].second - 1 >= 0) {
                    marked[arr[i].second - 1] = true;
                }
                if (arr[i].second + 1 < n) {
                    marked[arr[i].second + 1] = true;
                }
            }
        }

        return score;
    }
};