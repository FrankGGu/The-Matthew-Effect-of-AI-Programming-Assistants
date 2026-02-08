class Solution {
public:
    int countSpecialCharacters(string s) {
        int count = 0;
        for (char c : s) {
            if (!isalnum(c)) {
                count++;
            }
        }
        return count;
    }
};