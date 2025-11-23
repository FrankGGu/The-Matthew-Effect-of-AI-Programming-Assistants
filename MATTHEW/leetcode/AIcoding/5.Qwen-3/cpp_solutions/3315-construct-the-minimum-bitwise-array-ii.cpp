#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> minBitwiseArray(vector<int>& nums) {
        vector<int> result;
        for (int num : nums) {
            int x = 0;
            for (int i = 0; i < 30; ++i) {
                if ((x | (1 << i)) <= num) {
                    x |= (1 << i);
                }
            }
            result.push_back(x);
        }
        return result;
    }
};