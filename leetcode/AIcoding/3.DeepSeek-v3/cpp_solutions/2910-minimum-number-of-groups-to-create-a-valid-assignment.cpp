#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minGroupsForValidAssignment(vector<int>& nums) {
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        vector<int> counts;
        for (auto& [num, cnt] : freq) {
            counts.push_back(cnt);
        }

        int min_count = *min_element(counts.begin(), counts.end());
        int res = INT_MAX;

        for (int k = 1; k <= min_count; ++k) {
            bool valid = true;
            int total = 0;
            for (int cnt : counts) {
                int groups = cnt / (k + 1);
                int rem = cnt % (k + 1);
                if (rem == 0) {
                    total += groups;
                } else if (groups >= (k - rem)) {
                    total += groups + 1;
                } else {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                res = min(res, total);
            }
        }

        return res;
    }
};