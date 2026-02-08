class Solution {
public:
    int countVowelStrings(int n) {
        return pow(5, n) - pow(5, n - 1) + pow(5, n - 2) - pow(5, n - 3) + pow(5, n - 4);
    }
};