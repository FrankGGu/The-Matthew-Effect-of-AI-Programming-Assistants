class Solution {
public:
    int countCompleteSubstrings(string word, int k) {
        int n = word.size();
        int res = 0;
        for (int i = 0; i < n; ) {
            int start = i;
            i++;
            while (i < n && abs(word[i] - word[i-1]) <= 2) {
                i++;
            }
            res += helper(word.substr(start, i - start), k);
        }
        return res;
    }

private:
    int helper(const string& s, int k) {
        int res = 0;
        for (int unique = 1; unique <= 26; ++unique) {
            if (unique * k > s.size()) {
                break;
            }
            vector<int> count(26, 0);
            int left = 0;
            int valid = 0;
            for (int right = 0; right < s.size(); ++right) {
                int c = s[right] - 'a';
                count[c]++;
                if (count[c] == k) {
                    valid++;
                } else if (count[c] == k + 1) {
                    valid--;
                }
                while (count[c] > k) {
                    int lc = s[left] - 'a';
                    if (count[lc] == k) {
                        valid--;
                    }
                    count[lc]--;
                    if (count[lc] == k) {
                        valid++;
                    }
                    left++;
                }
                int currentUnique = 0;
                for (int i = 0; i < 26; ++i) {
                    if (count[i] > 0) {
                        currentUnique++;
                    }
                }
                if (currentUnique == unique && valid == unique) {
                    res++;
                }
            }
        }
        return res;
    }
};