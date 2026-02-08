#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> divisibilityArray(string nums) {
        int n = nums.size();
        vector<int> result(n, 0);
        long long current = 0;
        for (int i = 0; i < n; ++i) {
            current = (current * 10 + (nums[i] - '0')) % 1000000007;
            if (current % (i + 1) == 0) {
                result[i] = 1;
            }
        }
        return result;
    }
};