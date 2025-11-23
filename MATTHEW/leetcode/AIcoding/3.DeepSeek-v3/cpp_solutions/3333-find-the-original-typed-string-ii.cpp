class Solution {
public:
    string findOriginalString(vector<string>& typed) {
        string original;
        for (const string& s : typed) {
            if (original.empty()) {
                original = s;
                continue;
            }
            int i = 0, j = 0;
            while (i < original.size() && j < s.size()) {
                if (original[i] == s[j]) {
                    i++;
                    j++;
                } else {
                    j++;
                }
            }
            if (i == original.size()) {
                original = s;
            } else {
                return "";
            }
        }
        return original;
    }
};