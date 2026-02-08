#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> twoSum(vector<int>& price, int target) {
        unordered_set<int> seen;
        for (int i = 0; i < price.size(); ++i) {
            int complement = target - price[i];
            if (seen.count(complement)) {
                return {complement, price[i]};
            }
            seen.insert(price[i]);
        }
        return {};
    }
};