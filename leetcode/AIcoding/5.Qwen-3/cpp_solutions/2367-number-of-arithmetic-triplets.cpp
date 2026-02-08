#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int arithmeticTriplets(vector<int>& nums, int target) {
        unordered_map<int, int> count;
        int result = 0;
        for (int num : nums) {
            if (count.find(num - target) != count.end()) {
                result += count[num - target];
            }
            count[num]++;
        }
        return result;
    }
};