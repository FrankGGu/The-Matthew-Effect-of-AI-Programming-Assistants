#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countKDifference(vector<int>& nums, int k) {
        int count = 0;
        unordered_map<int, int> freq;

        for (int num : nums) {
            count += freq[num - k] + freq[num + k];
            freq[num]++;
        }

        return count;
    }
};