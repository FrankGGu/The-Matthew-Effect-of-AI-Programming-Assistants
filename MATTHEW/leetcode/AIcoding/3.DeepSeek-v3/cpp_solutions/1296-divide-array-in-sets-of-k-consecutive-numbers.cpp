#include <vector>
#include <map>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool isPossibleDivide(vector<int>& nums, int k) {
        if (nums.size() % k != 0) return false;
        map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }
        while (!count.empty()) {
            int start = count.begin()->first;
            for (int i = 0; i < k; ++i) {
                int num = start + i;
                if (count.find(num) == count.end()) {
                    return false;
                }
                if (--count[num] == 0) {
                    count.erase(num);
                }
            }
        }
        return true;
    }
};