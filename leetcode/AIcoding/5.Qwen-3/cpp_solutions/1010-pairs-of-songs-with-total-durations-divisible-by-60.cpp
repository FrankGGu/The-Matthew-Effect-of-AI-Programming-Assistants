#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int numPairsDivisibleBy60(vector<int>& nums) {
        vector<int> count(60, 0);
        int result = 0;
        for (int num : nums) {
            int mod = num % 60;
            if (mod == 0) {
                result += count[0];
            } else {
                result += count[60 - mod];
            }
            count[mod]++;
        }
        return result;
    }
};