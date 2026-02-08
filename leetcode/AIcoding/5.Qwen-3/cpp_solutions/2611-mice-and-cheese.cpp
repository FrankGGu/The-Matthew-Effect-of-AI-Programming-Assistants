#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int miceAndCheese(vector<int>& reward1, vector<int>& reward2, int k) {
        int n = reward1.size();
        vector<pair<int, int>> diff(n);

        for (int i = 0; i < n; ++i) {
            diff[i] = {reward1[i] - reward2[i], i};
        }

        sort(diff.begin(), diff.end(), greater<pair<int, int>>());

        int total = 0;
        for (int i = 0; i < k; ++i) {
            total += reward1[diff[i].second];
        }

        for (int i = k; i < n; ++i) {
            total += reward2[diff[i].second];
        }

        return total;
    }
};