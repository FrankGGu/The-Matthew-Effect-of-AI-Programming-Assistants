class Solution {
public:
    int longestCommonPrefix(vector<int>& arr1, vector<int>& arr2) {
        unordered_set<string> prefixes;
        for (int num : arr1) {
            string s = to_string(num);
            for (int i = 1; i <= s.size(); ++i) {
                prefixes.insert(s.substr(0, i));
            }
        }

        int max_len = 0;
        for (int num : arr2) {
            string s = to_string(num);
            for (int len = s.size(); len >= 1; --len) {
                if (prefixes.count(s.substr(0, len))) {
                    if (len > max_len) {
                        max_len = len;
                    }
                    break;
                }
            }
        }
        return max_len;
    }
};