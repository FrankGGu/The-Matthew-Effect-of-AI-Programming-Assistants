class Solution {
public:
    int maximumRemovals(string s, string p, vector<int>& removable) {
        int left = 0, right = removable.size();
        while (left < right) {
            int mid = left + (right - left + 1) / 2;
            if (isPossible(s, p, removable, mid)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }

private:
    bool isPossible(const string& s, const string& p, const vector<int>& removable, int k) {
        vector<bool> removed(s.size(), false);
        for (int i = 0; i < k; ++i) {
            removed[removable[i]] = true;
        }
        int i = 0, j = 0;
        while (i < s.size() && j < p.size()) {
            if (!removed[i] && s[i] == p[j]) {
                ++j;
            }
            ++i;
        }
        return j == p.size();
    }
};