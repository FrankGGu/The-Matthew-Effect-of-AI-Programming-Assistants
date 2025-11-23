#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<int>> outerTrees(vector<vector<int>>& trees) {
        auto cross = [](vector<int>& o, vector<int>& a, vector<int>& b) {
            return (a[0] - o[0]) * (b[1] - o[1]) - (a[1] - o[1]) * (b[0] - o[0]);
        };

        auto compare = [&](vector<int>& a, vector<int>& b) {
            int cross_val = cross(trees[0], a, b);
            if (cross_val == 0) {
                return (a[0] - trees[0][0]) * (a[0] - trees[0][0]) + (a[1] - trees[0][1]) * (a[1] - trees[0][1]) 
                       < (b[0] - trees[0][0]) * (b[0] - trees[0][0]) + (b[1] - trees[0][1]) * (b[1] - trees[0][1]);
            }
            return cross_val > 0;
        };

        sort(trees.begin(), trees.end(), compare);

        vector<vector<int>> res;
        int n = trees.size();
        for (int i = 0; i < n; ++i) {
            while (res.size() >= 2 && cross(res[res.size() - 2], res[res.size() - 1], trees[i]) <= 0) {
                res.pop_back();
            }
            res.push_back(trees[i]);
        }

        for (int i = n - 2; i >= 0; --i) {
            while (res.size() >= 2 && cross(res[res.size() - 2], res[res.size() - 1], trees[i]) <= 0) {
                res.pop_back();
            }
            res.push_back(trees[i]);
        }

        return res;
    }
};