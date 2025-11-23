#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int maximumCount(vector<int>& nums) {
        int negative = 0;
        int positive = 0;
        for (int num : nums) {
            if (num < 0) negative++;
            else if (num > 0) positive++;
        }
        return max(negative, positive);
    }
};