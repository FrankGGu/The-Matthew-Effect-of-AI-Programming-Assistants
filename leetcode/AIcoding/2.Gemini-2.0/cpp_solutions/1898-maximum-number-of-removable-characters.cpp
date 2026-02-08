#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int maximumRemovals(string s, string p, vector<int>& removable) {
        int left = 0, right = removable.size();
        int ans = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            string temp_s = s;
            vector<bool> removed(s.size(), false);

            for (int i = 0; i < mid; ++i) {
                removed[removable[i]] = true;
            }

            int p_idx = 0;
            for (int i = 0; i < temp_s.size(); ++i) {
                if (!removed[i] && p_idx < p.size() && temp_s[i] == p[p_idx]) {
                    p_idx++;
                }
            }

            if (p_idx == p.size()) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }

        return ans;
    }
};