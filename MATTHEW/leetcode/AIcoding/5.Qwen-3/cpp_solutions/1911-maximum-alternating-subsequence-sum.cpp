#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxAlternatingSum(vector<int>& nums) {
        int even = 0, odd = 0;
        for (int num : nums) {
            int new_even = max(even, odd + num);
            int new_odd = max(odd, even - num);
            even = new_even;
            odd = new_odd;
        }
        return even;
    }
};