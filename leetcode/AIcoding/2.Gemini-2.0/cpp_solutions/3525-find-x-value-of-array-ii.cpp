#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findXValue(vector<int>& nums) {
        int x = 0;
        for (int num : nums) {
            x = abs(x - num);
        }
        return x;
    }
};