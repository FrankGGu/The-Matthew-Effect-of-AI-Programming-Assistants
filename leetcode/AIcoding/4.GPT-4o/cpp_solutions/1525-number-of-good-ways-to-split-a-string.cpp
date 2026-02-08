class Solution {
public:
    int numSplits(string s) {
        int n = s.size();
        vector<int> left(n + 1, 0), right(n + 1, 0);
        unordered_set<char> leftSet, rightSet;

        for (int i = 0; i < n; ++i) {
            leftSet.insert(s[i]);
            left[i + 1] = leftSet.size();
        }

        for (int i = n - 1; i >= 0; --i) {
            rightSet.insert(s[i]);
            right[i] = rightSet.size();
        }

        int count = 0;
        for (int i = 1; i < n; ++i) {
            if (left[i] == right[i]) {
                count++;
            }
        }

        return count;
    }
};