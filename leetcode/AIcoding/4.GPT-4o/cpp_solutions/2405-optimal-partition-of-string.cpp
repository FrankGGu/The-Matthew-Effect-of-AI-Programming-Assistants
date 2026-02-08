class Solution {
public:
    int partitionString(string s) {
        unordered_set<char> seen;
        int count = 0;

        for (char c : s) {
            if (seen.count(c)) {
                count++;
                seen.clear();
            }
            seen.insert(c);
        }

        return count + (seen.empty() ? 0 : 1);
    }
};