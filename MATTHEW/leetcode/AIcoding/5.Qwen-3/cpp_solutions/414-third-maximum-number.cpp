#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    long long thirdMaximumNumber(vector<int>& nums) {
        long long first = LONG_MIN;
        long long second = LONG_MIN;
        long long third = LONG_MIN;

        for (int num : nums) {
            if (num == first || num == second || num == third) continue;
            if (num > first) {
                third = second;
                second = first;
                first = num;
            } else if (num > second) {
                third = second;
                second = num;
            } else if (num > third) {
                third = num;
            }
        }

        return third == LONG_MIN ? first : third;
    }
};