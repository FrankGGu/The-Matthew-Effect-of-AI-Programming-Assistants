class Solution {
public:
    string smallestSubstring(string s) {
        unordered_map<char, int> lastIndex;
        int minLength = INT_MAX;
        string result = "";
        int start = 0;

        for (int end = 0; end < s.size(); end++) {
            lastIndex[s[end]] = end;

            while (lastIndex.size() == end - start + 1) {
                if (end - start + 1 < minLength) {
                    minLength = end - start + 1;
                    result = s.substr(start, minLength);
                }
                lastIndex[s[start]]--;
                if (lastIndex[s[start]] == 0) {
                    lastIndex.erase(s[start]);
                }
                start++;
            }
        }

        return result;
    }
};