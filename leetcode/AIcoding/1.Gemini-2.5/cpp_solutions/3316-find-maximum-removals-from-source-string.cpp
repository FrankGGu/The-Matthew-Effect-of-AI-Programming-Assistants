class Solution {
public:
    bool isSubsequence(const std::string& s, const std::string& p, const std::vector<int>& removable, int k) {
        std::vector<bool> removed(s.length(), false);
        for (int i = 0; i < k; ++i) {
            removed[removable[i]] = true;
        }

        int s_ptr = 0;
        int p_ptr = 0;

        while (s_ptr < s.length() && p_ptr < p.length()) {
            if (!removed[s_ptr] && s[s_ptr] == p[p_ptr]) {
                p_ptr++;
            }
            s_ptr++;
        }

        return p_ptr == p.length();
    }

    int maximumRemovals(std::string s, std::string p, std::vector<int>& removable) {
        int low = 0;
        int high = removable.size();
        int ans = 0;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (isSubsequence(s, p, removable, mid)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return ans;
    }
};