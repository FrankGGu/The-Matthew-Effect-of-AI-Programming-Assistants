class Solution {
public:
    int expressiveWords(string s, vector<string>& words) {
        int res = 0;
        for (const string& word : words) {
            if (canStretch(word, s)) {
                res++;
            }
        }
        return res;
    }

private:
    bool canStretch(const string& word, const string& s) {
        int i = 0, j = 0;
        int m = word.size(), n = s.size();
        while (i < m && j < n) {
            if (word[i] != s[j]) {
                return false;
            }
            int cnt1 = 1, cnt2 = 1;
            while (i + 1 < m && word[i] == word[i + 1]) {
                i++;
                cnt1++;
            }
            while (j + 1 < n && s[j] == s[j + 1]) {
                j++;
                cnt2++;
            }
            if (cnt1 > cnt2 || (cnt2 < 3 && cnt1 != cnt2)) {
                return false;
            }
            i++;
            j++;
        }
        return i == m && j == n;
    }
};