#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

class Solution {
public:
    vector<int> minimumAbsoluteDifferenceQueries(vector<int>& arr, vector<vector<int>>& queries) {
        vector<int> result;
        int n = arr.size();
        sort(arr.begin(), arr.end());
        for (auto& q : queries) {
            int l = q[0];
            int r = q[1];
            int minDiff = INT_MAX;
            for (int i = l; i < r; ++i) {
                minDiff = min(minDiff, arr[i + 1] - arr[i]);
            }
            result.push_back(minDiff);
        }
        return result;
    }
};