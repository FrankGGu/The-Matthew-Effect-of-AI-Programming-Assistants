#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    bool isPossibleSplit(vector<int>& nums) {
        map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        for (auto& [num, freq] : count) {
            if (freq > 0) {
                int next = num + 1;
                int nextNext = num + 2;
                if (count[next] > 0 && count[nextNext] > 0) {
                    count[next]--;
                    count[nextNext]--;
                    freq--;
                } else if (count[next] > 0) {
                    count[next]--;
                    freq--;
                } else {
                    return false;
                }
            }
        }

        return true;
    }
};