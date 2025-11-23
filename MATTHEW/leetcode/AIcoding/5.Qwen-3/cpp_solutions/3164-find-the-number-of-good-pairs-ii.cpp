#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numIdenticalPairs(vector<int>& nums) {
        unordered_map<int, int> count;
        int result = 0;
        for (int num : nums) {
            result += count[num];
            count[num]++;
        }
        return result;
    }
};