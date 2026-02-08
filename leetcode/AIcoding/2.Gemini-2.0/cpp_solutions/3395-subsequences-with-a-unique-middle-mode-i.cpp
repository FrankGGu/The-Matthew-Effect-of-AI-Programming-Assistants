#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countSubsequences(vector<int>& nums) {
        int n = nums.size();
        int count = 0;

        for (int i = 0; i < (1 << n); ++i) {
            vector<int> sub;
            for (int j = 0; j < n; ++j) {
                if ((i >> j) & 1) {
                    sub.push_back(nums[j]);
                }
            }

            if (sub.empty()) continue;

            int len = sub.size();
            if (len % 2 == 0) continue;

            int middle = sub[len / 2];
            int freq = 0;
            for (int num : sub) {
                if (num == middle) {
                    freq++;
                }
            }

            bool unique = true;
            for (int num : sub) {
                if (num != middle) {
                    int other_freq = 0;
                    for(int x : sub) {
                        if(x == num) other_freq++;
                    }
                    if (other_freq >= freq) {
                        unique = false;
                        break;
                    }
                }
            }

            if (unique && freq > 0) {
                count++;
            }
        }

        return count;
    }
};