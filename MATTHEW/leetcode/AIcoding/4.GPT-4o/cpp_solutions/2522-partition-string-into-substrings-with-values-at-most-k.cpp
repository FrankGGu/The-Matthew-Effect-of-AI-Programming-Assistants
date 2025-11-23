class Solution {
public:
    int partitionString(string s, int k) {
        int count = 0;
        unordered_set<char> seen;

        for (char c : s) {
            if (seen.count(c) || c - '0' >= k) {
                count++;
                seen.clear();
            }
            seen.insert(c);
        }
        return count + (seen.empty() ? 0 : 1);
    }
};