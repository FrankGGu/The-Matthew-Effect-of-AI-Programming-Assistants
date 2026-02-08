class Solution {
public:
    int partitionString(string s) {
        unordered_set<char> seen;
        int count = 1;
        for (char c : s) {
            if (seen.find(c) != seen.end()) {
                count++;
                seen.clear();
            }
            seen.insert(c);
        }
        return count;
    }
};