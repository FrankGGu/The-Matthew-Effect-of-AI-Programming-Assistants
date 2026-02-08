class Solution {
public:
    int hashString(string s) {
        int hashValue = 0;
        for (char c : s) {
            hashValue = (hashValue * 31 + c) % 1000000007;
        }
        return hashValue;
    }
};