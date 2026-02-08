#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> majorityElement(vector<int>& nums) {
        vector<int> result;
        unordered_map<int, int> count;

        for (int num : nums) {
            count[num]++;
        }

        for (auto& pair : count) {
            if (pair.second > nums.size() / 3) {
                result.push_back(pair.first);
            }
        }

        return result;
    }
};