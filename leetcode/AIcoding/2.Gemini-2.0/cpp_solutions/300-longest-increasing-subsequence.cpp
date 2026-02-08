#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int lengthOfLIS(vector<int>& nums) {
        vector<int> tail;
        for (int num : nums) {
            auto it = lower_bound(tail.begin(), tail.end(), num);
            if (it == tail.end()) {
                tail.push_back(num);
            } else {
                *it = num;
            }
        }
        return tail.size();
    }
};