class Solution {
public:
    int maxUniqueSplit(string s) {
        unordered_set<string> seen;
        return backtrack(s, 0, seen);
    }

    int backtrack(string& s, int start, unordered_set<string>& seen) {
        if (start == s.size()) return seen.size();
        int maxCount = 0;
        for (int end = start + 1; end <= s.size(); ++end) {
            string substring = s.substr(start, end - start);
            if (seen.insert(substring).second) {
                maxCount = max(maxCount, backtrack(s, end, seen));
                seen.erase(substring);
            }
        }
        return maxCount;
    }
};