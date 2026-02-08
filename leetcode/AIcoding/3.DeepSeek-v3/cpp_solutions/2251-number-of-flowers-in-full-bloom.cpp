#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    vector<int> fullBloomFlowers(vector<vector<int>>& flowers, vector<int>& people) {
        vector<int> starts, ends;
        for (auto& f : flowers) {
            starts.push_back(f[0]);
            ends.push_back(f[1] + 1);
        }
        sort(starts.begin(), starts.end());
        sort(ends.begin(), ends.end());

        vector<int> res;
        for (int p : people) {
            auto it1 = upper_bound(starts.begin(), starts.end(), p) - starts.begin();
            auto it2 = upper_bound(ends.begin(), ends.end(), p) - ends.begin();
            res.push_back(it1 - it2);
        }
        return res;
    }
};