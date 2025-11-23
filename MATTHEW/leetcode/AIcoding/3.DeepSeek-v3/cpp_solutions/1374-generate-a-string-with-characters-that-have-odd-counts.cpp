class Solution {
public:
    string generateTheString(int n) {
        string result;
        if (n % 2 == 1) {
            result = string(n, 'a');
        } else {
            result = string(n - 1, 'a') + 'b';
        }
        return result;
    }
};