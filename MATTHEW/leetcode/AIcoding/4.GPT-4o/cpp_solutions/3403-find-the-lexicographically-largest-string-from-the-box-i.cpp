class Solution {
public:
    string findLargestString(string s) {
        int n = s.size();
        string result = s;
        for (int i = 0; i < n; ++i) {
            if (s[i] == 'a') {
                continue;
            }
            char original = s[i];
            s[i] = 'a';
            string temp = s;
            temp = largestString(temp);
            if (temp > result) {
                result = temp;
            }
            s[i] = original;
        }
        return result;
    }

    string largestString(string s) {
        int n = s.size();
        for (int i = 0; i < n; ++i) {
            if (s[i] == 'a') {
                continue;
            }
            for (char c = 'z'; c > 'a'; --c) {
                string temp = s;
                temp[i] = c;
                if (temp > s) {
                    s = temp;
                }
            }
        }
        return s;
    }
};