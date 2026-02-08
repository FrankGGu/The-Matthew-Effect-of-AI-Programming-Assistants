#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    long long beautifulSubarrays(vector<int>& nums) {
        unordered_map<int, int> prefixXorCount;
        prefixXorCount[0] = 1; 
        int currentXor = 0;
        long long count = 0;
        for (int num : nums) {
            currentXor ^= num;
            count += prefixXorCount[currentXor];
            prefixXorCount[currentXor]++;
        }
        return count;
    }
};