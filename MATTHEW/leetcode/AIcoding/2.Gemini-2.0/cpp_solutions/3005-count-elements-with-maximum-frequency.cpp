#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxFrequencyElements(vector<int>& nums) {
        unordered_map<int, int> counts;
        int max_freq = 0;
        for (int num : nums) {
            counts[num]++;
            max_freq = max(max_freq, counts[num]);
        }

        int result = 0;
        for (auto const& [key, val] : counts) {
            if (val == max_freq) {
                result += val;
            }
        }

        return result;
    }
};