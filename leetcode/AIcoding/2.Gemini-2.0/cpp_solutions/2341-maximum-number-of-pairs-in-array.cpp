#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> numberOfPairs(vector<int>& nums) {
        unordered_map<int, int> counts;
        for (int num : nums) {
            counts[num]++;
        }

        int pairs = 0;
        int leftovers = 0;

        for (auto const& [key, val] : counts) {
            pairs += val / 2;
            leftovers += val % 2;
        }

        return {pairs, (int)nums.size() - 2 * pairs};
    }
};