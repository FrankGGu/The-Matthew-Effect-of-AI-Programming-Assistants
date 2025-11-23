#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<bool> prefixesDivBy5(vector<int>& nums) {
        vector<bool> result;
        int current = 0;
        for (int num : nums) {
            current = (current * 2 + num) % 10;
            result.push_back(current % 5 == 0);
        }
        return result;
    }
};