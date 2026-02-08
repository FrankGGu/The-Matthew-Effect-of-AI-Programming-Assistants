#include <vector>

using namespace std;

class Solution {
public:
    long long beautifulSubarrays(vector<int>& nums) {
        long long count = 0;
        int prefixXor = 0;
        vector<int> freq(1 << 20, 0);
        freq[0] = 1;

        for (int num : nums) {
            prefixXor ^= num;
            count += freq[prefixXor];
            freq[prefixXor]++;
        }

        return count;
    }
};