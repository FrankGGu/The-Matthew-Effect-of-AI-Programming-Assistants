class Solution {
public:
    int countBinarySubstrings(string s) {
        int count = 0;
        vector<int> groups;
        for (int i = 0; i < s.size(); ) {
            int j = i;
            while (j < s.size() && s[j] == s[i]) j++;
            groups.push_back(j - i);
            i = j;
        }
        for (int i = 1; i < groups.size(); i++) {
            count += min(groups[i - 1], groups[i]);
        }
        return count;
    }
};