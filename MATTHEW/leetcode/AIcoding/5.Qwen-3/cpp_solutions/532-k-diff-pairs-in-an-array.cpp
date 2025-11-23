#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int findPairs(vector<int>& nums, int k) {
        map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        int result = 0;
        for (auto& pair : count) {
            if (k == 0) {
                if (pair.second >= 2) {
                    result++;
                }
            } else {
                if (count.find(pair.first + k) != count.end()) {
                    result++;
                }
            }
        }
        return result;
    }
};