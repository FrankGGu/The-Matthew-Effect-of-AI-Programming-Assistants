#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int minKBitFlips(int k, vector<int>& nums) {
        int n = nums.size();
        vector<int> flip(n, 0);
        int currentFlip = 0;
        int res = 0;

        for (int i = 0; i < n; ++i) {
            if (i >= k) {
                currentFlip -= flip[i - k];
            }
            if ((nums[i] + currentFlip) % 2 == 0) {
                res++;
                currentFlip++;
                if (i + k <= n) {
                    flip[i] = 1;
                }
            }
        }

        return res;
    }
};