#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countTriplets(vector<int>& nums) {
        int n = nums.size();
        long long count = 0;
        unordered_map<int, int> freq;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int xor_val = nums[i] ^ nums[j];
                if (freq.count(xor_val ^ nums[i]) > 0) {
                    count += freq[xor_val ^ nums[i]];
                }
            }
            freq[nums[i]]++;
        }

        return count;
    }
};