class Solution {
public:
    vector<string> commonChars(vector<string>& A) {
        vector<int> count(26, INT_MAX);
        for (const string& str : A) {
            vector<int> temp(26, 0);
            for (char c : str) {
                temp[c - 'a']++;
            }
            for (int i = 0; i < 26; i++) {
                count[i] = min(count[i], temp[i]);
            }
        }
        vector<string> result;
        for (int i = 0; i < 26; i++) {
            while (count[i]--) {
                result.push_back(string(1, 'a' + i));
            }
        }
        return result;
    }
};