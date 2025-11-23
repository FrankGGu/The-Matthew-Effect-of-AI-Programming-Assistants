#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> relocateMarbles(vector<int>& nums, vector<int>& moveFrom, vector<int>& moveTo) {
        unordered_set<int> marbles(nums.begin(), nums.end());
        for (int i = 0; i < moveFrom.size(); ++i) {
            if (marbles.count(moveFrom[i])) {
                marbles.erase(moveFrom[i]);
                marbles.insert(moveTo[i]);
            }
        }
        vector<int> result(marbles.begin(), marbles.end());
        sort(result.begin(), result.end());
        return result;
    }
};