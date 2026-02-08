#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumLength(vector<int>& nums) {
        unordered_map<int, int> count;
        for (int num : nums) {
            count[num]++;
        }

        sort(nums.begin(), nums.end());
        nums.erase(unique(nums.begin(), nums.end()), nums.end());

        int ans = 0;
        for (int num : nums) {
            int len = 0;
            if (count[1] > 0) {
                if (num == 1) {
                    len = (count[1] % 2 == 0) ? (count[1] - 1) : count[1];
                } else {
                    int curr = num;
                    int currLen = 0;
                    while (count.count(curr)) {
                        if (count[curr] > 0) {
                            currLen++;
                        } else {
                            break;
                        }
                        if (curr > 100000) break;
                        curr = (long long)curr * curr;
                        if (curr > 10000000000) break;
                    }
                    len = 2 * currLen - 1;
                }
            }
           ans = max(ans, len);
        }

        return ans;
    }
};