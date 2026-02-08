#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minimumIndex(vector<int>& nums) {
        unordered_map<int, int> freq;
        int dominant = -1;
        for (int num : nums) {
            freq[num]++;
            if (dominant == -1 || freq[num] > freq[dominant]) {
                dominant = num;
            }
        }

        int total = freq[dominant];
        int count = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == dominant) {
                count++;
            }
            if (count * 2 > (i + 1) && (total - count) * 2 > (nums.size() - i - 1)) {
                return i;
            }
        }
        return -1;
    }
};