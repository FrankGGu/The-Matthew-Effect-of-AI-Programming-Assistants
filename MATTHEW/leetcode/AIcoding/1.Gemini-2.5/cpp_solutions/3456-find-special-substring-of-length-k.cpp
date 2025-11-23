class Solution {
public:
    int findSpecialSubstringOfLengthK(std::string s, int k) {
        if (k <= 0) {
            return 0;
        }
        if