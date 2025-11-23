class Solution {
public:
    string encryptPath(string path) {
        string result;
        for (char c : path) {
            if (c == '/') {
                result += c;
            } else {
                result += '*';
            }
        }
        return result;
    }
};