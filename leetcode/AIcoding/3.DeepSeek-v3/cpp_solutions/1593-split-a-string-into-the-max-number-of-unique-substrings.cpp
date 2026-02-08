class Solution {
public:
    void backtrack(const string& s, int start, unordered_set<string>& seen, int& max_count) {
        if (start == s.length()) {
            if (seen.size() > max_count) {
                max_count = seen.size();
            }
            return;
        }

        for (int end = start + 1; end <= s.length(); ++end) {
            string substring = s.substr(start, end - start);
            if (seen.find(substring) == seen.end()) {
                seen.insert(substring);
                backtrack(s, end, seen, max_count);
                seen.erase(substring);
            }
        }
    }

    int maxUniqueSplit(string s) {
        unordered_set<string> seen;
        int max_count = 0;
        backtrack(s, 0, seen, max_count);
        return max_count;
    }
};