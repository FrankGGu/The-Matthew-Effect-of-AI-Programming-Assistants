#include <vector>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findMaxK(vector<int>& nums) {
        unordered_set<int> seen;
        int max_k = -1;
        for (int num : nums) {
            if (seen.count(-num)) {
                max_k = max(max_k, abs(num));
            }
            seen.insert(num);
        }
        return max_k;
    }
};