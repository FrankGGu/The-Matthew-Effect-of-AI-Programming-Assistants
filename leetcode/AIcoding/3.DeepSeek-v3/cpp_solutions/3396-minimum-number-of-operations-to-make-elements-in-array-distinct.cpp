#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int operations = 0;
        for (auto& [num, count] : freq) {
            if (count > 1) {
                operations += count - 1;
            }
        }

        return operations;
    }
};