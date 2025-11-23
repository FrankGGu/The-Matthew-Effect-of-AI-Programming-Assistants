#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    bool isPossible(vector<int>& nums) {
        unordered_map<int, int> count, tails;
        for (int num : nums) {
            count[num]++;
        }

        for (int num : nums) {
            if (count[num] == 0) continue;

            if (tails[num - 1] > 0) {
                tails[num - 1]--;
                tails[num]++;
                count[num]--;
            } else if (count[num + 1] > 0 && count[num + 2] > 0) {
                count[num]--;
                count[num + 1]--;
                count[num + 2]--;
                tails[num + 2]++;
            } else {
                return false;
            }
        }

        return true;
    }
};