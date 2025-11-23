#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minLengthAfterRemovals(vector<int>& nums) {
        int n = nums.size();
        unordered_set<int> freq;
        int maxFreq = 0;
        for (int num : nums) {
            freq.insert(num);
            maxFreq = max(maxFreq, ++freq[num]);
        }
        if (maxFreq > (n + 1) / 2) {
            return 2 * maxFreq - n;
        } else {
            return n % 2 == 0 ? 1 : 2;
        }
    }
};