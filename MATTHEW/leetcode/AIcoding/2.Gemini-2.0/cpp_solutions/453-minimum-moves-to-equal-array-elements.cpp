#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minMoves(vector<int>& nums) {
        int minVal = *min_element(nums.begin(), nums.end());
        int moves = 0;
        for (int num : nums) {
            moves += num - minVal;
        }
        return moves;
    }
};