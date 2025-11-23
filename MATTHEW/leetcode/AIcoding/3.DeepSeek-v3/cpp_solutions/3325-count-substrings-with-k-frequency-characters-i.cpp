class Solution {
public:
    int countSubstrings(string s, int k) {
        int n = s.size();
        int res = 0;
        for (int i = 0; i < n; ++i) {
            unordered_map<char, int> freq;
            for (int j = i; j < n; ++j) {
                freq[s[j]]++;
                bool hasK = false;
                for (auto& p : freq) {
                    if (p.second == k) {
                        hasK = true;
                        break;
                    }
                }
                if (hasK) res++;
            }
        }
        return res;
    }
};