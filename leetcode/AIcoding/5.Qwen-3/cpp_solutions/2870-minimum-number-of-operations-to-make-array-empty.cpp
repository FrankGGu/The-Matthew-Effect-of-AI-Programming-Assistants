#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        int operations = 0;
        for (auto& [num, freq] : count) {
            if (freq == 1) {
                return -1;
            }
            operations += freq / 3;
            if (freq % 3 != 0) {
                operations++;
            }
        }
        return operations;
    }
};