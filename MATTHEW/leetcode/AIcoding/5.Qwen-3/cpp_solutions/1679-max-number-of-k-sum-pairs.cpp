#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int maxKSumPairs(vector<int>& nums, int k) {
        unordered_map<int, int> count;
        int result = 0;

        for (int num : nums) {
            int complement = k - num;
            if (count[complement] > 0) {
                result++;
                count[complement]--;
                if (count[complement] == 0) {
                    count.erase(complement);
                }
            } else {
                count[num]++;
            }
        }

        return result;
    }
};