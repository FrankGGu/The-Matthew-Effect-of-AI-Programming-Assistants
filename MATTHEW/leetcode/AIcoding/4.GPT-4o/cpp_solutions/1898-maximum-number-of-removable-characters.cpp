class Solution {
public:
    bool canRemove(string s, string p, int mid) {
        unordered_set<int> toRemove;
        for (int i = 0; i < mid; ++i) {
            toRemove.insert(s[i] - 'a');
        }
        int j = 0;
        for (int i = 0; i < p.size(); ++i) {
            while (j < s.size() && (toRemove.count(s[j] - 'a') > 0 || s[j] != p[i])) {
                j++;
            }
            if (j == s.size()) return false;
            j++;
        }
        return true;
    }

    int maximumRemovals(string s, string p, vector<int>& removable) {
        int left = 0, right = removable.size(), ans = 0;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (canRemove(s, p, mid)) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return ans;
    }
};