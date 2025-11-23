#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int countKDifference(vector<int>& nums, int k) {
        unordered_map<int, int> count;
        int result = 0;

        for (int num : nums) {
            result += count[num - k] + count[num + k];
            count[num]++;
        }

        return result;
    }
};