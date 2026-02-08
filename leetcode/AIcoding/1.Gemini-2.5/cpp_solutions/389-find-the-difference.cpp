class Solution {
public:
    char findTheDifference(std::string s, std::string t) {
        char diff = 0;
        for (char c : s) {
            diff ^= c;
        }
        for (char c : t) {
            diff ^= c;
        }
        return diff;
    }
};