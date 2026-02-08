#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findLHS(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int max_len = 0;
        for (auto const& [num, count] : freq) {
            if (freq.count(num + 1)) {
                max_len = max(max_len, count + freq[num + 1]);
            }
        }

        return max_len;
    }
};