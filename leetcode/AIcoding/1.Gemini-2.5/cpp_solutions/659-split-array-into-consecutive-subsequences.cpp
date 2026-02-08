#include <vector>
#include <map>

class Solution {
public:
    bool isPossible(std::vector<int>& nums) {
        std::map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        std::map<int, int> end_with;

        for (int num : nums) {
            if (freq[num] == 0) {
                continue;
            }

            freq[num]--;

            if (end_with[num - 1] > 0) {
                end_with[num - 1]--;
                end_with[num]++;
            } else if (freq[num + 1] > 0 && freq[num + 2] > 0) {
                freq[num + 1]--;
                freq[num + 2]--;
                end_with[num + 2]++;
            } else {
                return false;
            }
        }

        return true;
    }
};