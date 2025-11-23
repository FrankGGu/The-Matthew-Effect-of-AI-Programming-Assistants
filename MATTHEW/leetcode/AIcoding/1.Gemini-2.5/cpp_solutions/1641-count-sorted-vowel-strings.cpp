class Solution {
public:
    int countVowelStrings(int n) {
        long long numerator = (long long)(n + 4) * (n + 3) * (n + 2) * (n + 1);
        long long denominator = 24; 

        return (int)(numerator / denominator);
    }
};