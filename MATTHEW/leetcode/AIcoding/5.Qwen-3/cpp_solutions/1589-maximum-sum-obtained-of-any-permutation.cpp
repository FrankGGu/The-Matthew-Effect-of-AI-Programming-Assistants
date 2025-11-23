#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxSumObtained(vector<int>& nums) {
        vector<int> freq(21, 0);
        for (int num : nums) {
            freq[num]++;
        }

        int result = 0;
        int currentMax = 0;
        for (int i = 20; i >= 0; --i) {
            if (freq[i] > 0) {
                currentMax += i;
                result += currentMax;
            }
        }
        return result;
    }
};