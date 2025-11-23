#include <vector>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> relocateMarbles(vector<int>& nums, vector<int>& moveFrom, vector<int>& moveTo) {
        set<int> positions(nums.begin(), nums.end());

        for (int i = 0; i < moveFrom.size(); ++i) {
            if (positions.count(moveFrom[i])) {
                positions.erase(moveFrom[i]);
                positions.insert(moveTo[i]);
            }
        }

        vector<int> result(positions.begin(), positions.end());
        sort(result.begin(), result.end());

        return result;
    }
};