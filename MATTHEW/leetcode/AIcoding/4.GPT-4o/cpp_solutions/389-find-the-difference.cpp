class Solution {
public:
    char findTheDifference(string s, string t) {
        int charSum = 0;
        for (char c : s) charSum += c;
        for (char c : t) charSum -= c;
        return charSum;
    }
};