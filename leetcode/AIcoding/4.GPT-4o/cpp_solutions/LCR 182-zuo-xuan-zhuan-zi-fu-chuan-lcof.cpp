class Solution {
public:
    string generateDynamicPassword(string password, string salt) {
        string combined = password + salt;
        string result;
        for (char c : combined) {
            result += to_string((c - '0' + 1) % 10);
        }
        return result;
    }
};