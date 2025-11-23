#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    bool isPossibleDivide(vector<int>& nums, int k) {
        if (nums.size() % k != 0) {
            return false;
        }

        map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        while (!count.empty()) {
            int start = count.begin()->first;
            for (int i = 0; i < k; ++i) {
                int current = start + i;
                if (count.find(current) == count.end()) {
                    return false;
                }
                count[current]--;
                if (count[current] == 0) {
                    count.erase(current);
                }
            }
        }

        return true;
    }
};