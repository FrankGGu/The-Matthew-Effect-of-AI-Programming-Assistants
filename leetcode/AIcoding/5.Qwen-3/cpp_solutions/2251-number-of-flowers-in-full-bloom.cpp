#include <iostream>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    vector<int> fullBloomFlowers(vector<vector<int>>& flowers, vector<int>& people) {
        vector<int> start;
        vector<int> end;
        for (auto& flower : flowers) {
            start.push_back(flower[0]);
            end.push_back(flower[1]);
        }
        sort(start.begin(), start.end());
        sort(end.begin(), end.end());

        vector<int> res;
        for (int t : people) {
            int open = upper_bound(start.begin(), start.end(), t) - start.begin();
            int close = lower_bound(end.begin(), end.end(), t) - end.begin();
            res.push_back(open - close);
        }
        return res;
    }
};