#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumValue(vector<int>& nums) {
        int max_val = 0;
        for (int num : nums) {
            int current_val = num;
            if (num > 0) {
                int temp = num;
                while (temp > 0) {
                    current_val = max(current_val, temp % 10);
                    temp /= 10;
                }
            }
            max_val = max(max_val, current_val);
        }
        return max_val;
    }
};