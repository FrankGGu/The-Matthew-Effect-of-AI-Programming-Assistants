#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int beautifulSplits(vector<int>& nums) {
        int n = nums.size();
        int count = 0;
        vector<int> prefix(n, 0);
        unordered_map<int, int> freq;
        freq[0] = 1;
        int xorSum = 0;

        for (int i = 0; i < n; ++i) {
            xorSum ^= nums[i];
            prefix[i] = xorSum;
        }

        for (int i = 0; i < n - 1; ++i) {
            int left = prefix[i];
            int right = prefix[n - 1] ^ prefix[i];
            if (left == right) {
                count++;
            }
        }

        return count;
    }
};