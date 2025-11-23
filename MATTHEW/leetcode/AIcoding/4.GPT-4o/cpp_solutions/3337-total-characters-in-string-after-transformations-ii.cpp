class Solution {
public:
    int transformedStringLength(string s) {
        int count = 0;
        for (char c : s) {
            if (isalpha(c)) {
                count++;
            }
        }
        return count;
    }
};