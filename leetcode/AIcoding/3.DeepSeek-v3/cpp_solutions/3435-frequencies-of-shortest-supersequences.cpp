#include <vector>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    vector<int> shortestSeq(vector<int>& big, vector<int>& small) {
        unordered_map<int, int> need;
        for (int num : small) {
            need[num]++;
        }
        int missing = small.size();
        int left = 0, right = 0;
        int min_len = INT_MAX;
        int start = 0;

        while (right < big.size()) {
            int num = big[right];
            if (need.count(num)) {
                if (need[num] > 0) {
                    missing--;
                }
                need[num]--;
            }
            right++;

            while (missing == 0) {
                if (right - left < min_len) {
                    min_len = right - left;
                    start = left;
                }
                int left_num = big[left];
                if (need.count(left_num)) {
                    need[left_num]++;
                    if (need[left_num] > 0) {
                        missing++;
                    }
                }
                left++;
            }
        }

        if (min_len == INT_MAX) {
            return {};
        }
        return {start, start + min_len - 1};
    }
};