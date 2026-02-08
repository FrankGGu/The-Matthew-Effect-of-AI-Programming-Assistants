#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int numEquivDominoPairs(vector<vector<int>>& dominoes) {
        map<pair<int, int>, int> count;
        int ans = 0;
        for (auto& domino : dominoes) {
            int a = min(domino[0], domino[1]);
            int b = max(domino[0], domino[1]);
            if (count.find({a, b}) != count.end()) {
                ans += count[{a, b}];
                count[{a, b}]++;
            } else {
                count[{a, b}] = 1;
            }
        }
        return ans;
    }
};