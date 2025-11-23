#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    vector<int> numberOfPairs(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int pairs = 0;
        int leftovers = 0;
        for (auto& kv : freq) {
            pairs += kv.second / 2;
            leftovers += kv.second % 2;
        }

        return {pairs, leftovers};
    }
};