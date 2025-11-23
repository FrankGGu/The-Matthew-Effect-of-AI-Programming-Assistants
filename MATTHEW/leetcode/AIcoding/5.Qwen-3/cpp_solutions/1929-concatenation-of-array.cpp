#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> getConcatenation(vector<int>& nums) {
        vector<int> result = nums;
        for (int num : nums) {
            result.push_back(num);
        }
        return result;
    }
};