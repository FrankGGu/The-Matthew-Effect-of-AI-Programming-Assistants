#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    bool isPossibleDivide(vector<int>& nums, int k) {
        if (nums.size() % k != 0) return false;

        map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        for (auto it = count.begin(); it != count.end(); ++it) {
            if (it->second > 0) {
                int num = it->first;
                int freq = it->second;
                for (int i = 0; i < k; ++i) {
                    if (count[num + i] < freq) return false;
                    count[num + i] -= freq;
                }
            }
        }

        return true;
    }
};