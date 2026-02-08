class Solution {
public:
    bool checkIfPangram(string sentence) {
        unordered_set<char> seen;
        for (char c : sentence) {
            seen.insert(c);
        }
        return seen.size() == 26;
    }
};