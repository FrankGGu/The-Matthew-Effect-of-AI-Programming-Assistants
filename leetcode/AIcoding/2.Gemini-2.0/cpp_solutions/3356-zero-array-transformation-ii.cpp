#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool canTransform(vector<int>& nums) {
        int n = nums.size();
        vector<int> pos;
        vector<int> neg;

        for (int i = 0; i < n; ++i) {
            if (nums[i] > 0) {
                pos.push_back(i);
            } else if (nums[i] < 0) {
                neg.push_back(i);
            }
        }

        int pos_idx = 0;
        int neg_idx = 0;

        while (pos_idx < pos.size() && neg_idx < neg.size()) {
            if (pos[pos_idx] > neg[neg_idx]) {
                return false;
            }
            pos_idx++;
            neg_idx++;
        }

        return true;
    }
};