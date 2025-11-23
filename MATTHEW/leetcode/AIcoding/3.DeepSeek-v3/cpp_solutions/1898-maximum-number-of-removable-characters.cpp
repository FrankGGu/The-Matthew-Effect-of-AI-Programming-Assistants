class Solution {
public:
    int maximumRemovableCharacters(string s, string p, vector<int>& removable) {
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
    bool isPossible(string s, string p, vector<int>& removable, int k) {
        unordered_set<int> removed;
        for (int i = 0; i < k; ++i) {
            removed.insert(removable[i]);
        }
        int i = 0, j = 0;
        while (i < s.size() && j < p.size()) {
            if (removed.count(i) || s[i] != p[j]) {
                i++;
            } else {
                i++;
                j++;
            }
        }
        return j == p.size();
    }
};