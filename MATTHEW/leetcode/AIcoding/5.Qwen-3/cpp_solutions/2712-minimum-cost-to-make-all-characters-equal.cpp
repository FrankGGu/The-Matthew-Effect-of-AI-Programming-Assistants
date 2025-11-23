#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long minimumCost(string s, int k, int candidates) {
        int n = s.size();
        vector<int> left;
        vector<int> right;

        for (int i = 0; i < k && i < n; ++i) {
            left.push_back(s[i]);
        }

        for (int i = n - 1; i >= n - k && i >= 0; --i) {
            right.push_back(s[i]);
        }

        sort(left.begin(), left.end());
        sort(right.begin(), right.end());

        long long cost = 0;

        for (int i = 0; i < candidates; ++i) {
            if (i < left.size() && i < right.size()) {
                cost += min(left[i], right[i]);
            } else if (i < left.size()) {
                cost += left[i];
            } else {
                cost += right[i];
            }
        }

        return cost;
    }
};