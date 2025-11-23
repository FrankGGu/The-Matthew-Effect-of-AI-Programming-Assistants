#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int unequalTriplets(int n, vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        int total = 0;
        int left = 0;
        int right = n;

        for (auto& [num, count] : freq) {
            total += left * count * (right - count);
            left += count;
            right -= count;
        }

        return total;
    }
};