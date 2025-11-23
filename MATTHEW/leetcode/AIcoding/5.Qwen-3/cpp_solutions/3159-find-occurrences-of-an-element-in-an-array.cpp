#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> occurrencesOfElement(vector<int>& nums, int x) {
        vector<int> result;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == x) {
                result.push_back(i);
            }
        }
        return result;
    }
};