#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countKDifference(int k, vector<int>& nums) {
        unordered_map<int, int> count;
        int result = 0;
        for (int num : nums) {
            result += count[num - k];
            result += count[num + k];
            count[num]++;
        }
        return result;
    }
};