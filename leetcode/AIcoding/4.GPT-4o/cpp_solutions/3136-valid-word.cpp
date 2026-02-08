class Solution {
public:
    bool isValidWord(string word) {
        int n = word.size();
        if (n < 1 || n > 15) return false;
        for (char c : word) {
            if (!isalpha(c)) return false;
        }
        return true;
    }
};