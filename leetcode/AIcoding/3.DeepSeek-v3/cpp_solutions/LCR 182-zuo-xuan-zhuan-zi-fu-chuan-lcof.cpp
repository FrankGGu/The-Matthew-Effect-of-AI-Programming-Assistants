class Solution {
public:
    string dynamicPassword(string password, int target) {
        int n = password.length();
        if (n == 0) return password;
        target %= n;
        return password.substr(target) + password.substr(0, target);
    }
};