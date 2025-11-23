#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumCount(vector<int>& nums) {
        int pos_count = 0;
        int neg_count = 0;
        for (int num : nums) {
            if (num > 0) {
                pos_count++;
            } else if (num < 0) {
                neg_count++;
            }
        }
        return max(pos_count, neg_count);
    }
};