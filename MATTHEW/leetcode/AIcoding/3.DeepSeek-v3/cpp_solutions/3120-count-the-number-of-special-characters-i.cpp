class Solution {
public:
    int numberOfSpecialChars(string word) {
        unordered_set<char> lower;
        unordered_set<char> upper;
        for (char c : word) {
            if (islower(c)) {
                lower.insert(c);
            } else {
                upper.insert(tolower(c));
            }
        }
        int count = 0;
        for (char c : lower) {
            if (upper.count(c)) {
                count++;
            }
        }
        return count;
    }
};