class Solution {
public:
    string maximumNumber(string a, string b) {
        return a + b > b + a ? a + b : b + a;
    }
};