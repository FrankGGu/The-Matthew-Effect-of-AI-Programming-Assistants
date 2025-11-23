class Solution {
public:
    int minimumOperations(string s) {
        int count = 0;
        for (int i = 0; i < s.size(); i++) {
            if (s[i] != '0') {
                count++;
                i++;
            }
        }
        return count;
    }
};