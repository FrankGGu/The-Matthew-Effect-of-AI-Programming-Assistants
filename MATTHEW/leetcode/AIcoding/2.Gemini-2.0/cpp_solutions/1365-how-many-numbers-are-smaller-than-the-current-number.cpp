#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> smallerNumbersThanCurrent(vector<int>& nums) {
        vector<int> sortedNums = nums;
        sort(sortedNums.begin(), sortedNums.end());
        vector<int> result;
        for (int num : nums) {
            result.push_back(lower_bound(sortedNums.begin(), sortedNums.end(), num) - sortedNums.begin());
        }
        return result;
    }
};