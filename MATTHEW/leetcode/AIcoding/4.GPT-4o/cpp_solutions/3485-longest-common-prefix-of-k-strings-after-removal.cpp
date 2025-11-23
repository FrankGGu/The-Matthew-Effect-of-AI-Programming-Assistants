class Solution {
public:
    string longestCommonPrefix(vector<string>& strs) {
        if (strs.empty()) return "";
        string prefix = strs[0];
        for (int i = 1; i < strs.size(); ++i) {
            while (strs[i].find(prefix) != 0) {
                prefix = prefix.substr(0, prefix.size() - 1);
                if (prefix.empty()) return "";
            }
        }
        return prefix;
    }

    string longestCommonPrefixAfterRemoval(vector<string>& strs) {
        string lcp = longestCommonPrefix(strs);
        for (auto& str : strs) {
            str = str.substr(lcp.size());
        }
        return longestCommonPrefix(strs);
    }
};