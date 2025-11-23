#include <vector>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int longestSquareStreak(vector<int>& nums) {
        unordered_set<int> s(nums.begin(), nums.end());
        int max_len = 0;
        for (int num : nums) {
            if (s.count(num)) {
                int len = 1;
                long long curr = (long long)num;
                while (true) {
                    long long next = curr * curr;
                    if (next > 100000 || next < 0 || !s.count((int)next)) break;
                    len++;
                    curr = next;
                }
                max_len = max(max_len, len);
            }
        }
        return max_len > 1 ? max_len : -1;
    }
};