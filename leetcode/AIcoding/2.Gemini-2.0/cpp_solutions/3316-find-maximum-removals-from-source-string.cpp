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

            string filtered_s = "";
            for (int i = 0; i < s.size(); ++i) {
                if (!removed[i]) {
                    filtered_s += s[i];
                }
            }

            int p_idx = 0;
            int s_idx = 0;
            while (s_idx < filtered_s.size() && p_idx < p.size()) {
                if (filtered_s[s_idx] == p[p_idx]) {
                    p_idx++;
                }
                s_idx++;
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