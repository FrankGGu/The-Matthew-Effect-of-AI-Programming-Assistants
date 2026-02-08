class Solution {
public:
    string smallestSubsequence(string s) {
        vector<int> lastIndex(26, -1);
        vector<bool> inResult(26, false);
        string result = "";

        for (int i = 0; i < s.size(); ++i) {
            lastIndex[s[i] - 'a'] = i;
        }

        for (int i = 0; i < s.size(); ++i) {
            if (inResult[s[i] - 'a']) continue;
            while (!result.empty() && result.back() > s[i] && lastIndex[result.back() - 'a'] > i) {
                inResult[result.back() - 'a'] = false;
                result.pop_back();
            }
            result.push_back(s[i]);
            inResult[s[i] - 'a'] = true;
        }

        return result;
    }
};