#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> longestObstacleCourseAtEachPosition(vector<int>& obstacles) {
        vector<int> res, lis;
        for (int num : obstacles) {
            auto it = upper_bound(lis.begin(), lis.end(), num);
            if (it == lis.end()) {
                lis.push_back(num);
                res.push_back(lis.size());
            } else {
                *it = num;
                res.push_back(it - lis.begin() + 1);
            }
        }
        return res;
    }
};