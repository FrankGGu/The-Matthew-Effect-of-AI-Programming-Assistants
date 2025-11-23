#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int maxCorrelation(const vector<int>& nums) {
        int result = 0;
        for (int i = 0; i < 32; ++i) {
            int count = 0;
            for (int num : nums) {
                if ((num >> i) & 1) {
                    ++count;
                }
            }
            result = max(result, count);
        }
        return result;
    }
};