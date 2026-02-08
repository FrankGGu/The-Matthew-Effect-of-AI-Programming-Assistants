class Solution {
public:
    bool isAlienSorted(vector<string>& words, string order) {
        int mapping[26];
        for (int i = 0; i < order.size(); i++) {
            mapping[order[i] - 'a'] = i;
        }
        for (int i = 1; i < words.size(); i++) {
            if (!compare(words[i - 1], words[i], mapping)) {
                return false;
            }
        }
        return true;
    }

    bool compare(string& a, string& b, int mapping[]) {
        int n = a.size(), m = b.size();
        for (int i = 0; i < min(n, m); i++) {
            if (mapping[a[i] - 'a'] < mapping[b[i] - 'a']) {
                return true;
            } else if (mapping[a[i] - 'a'] > mapping[b[i] - 'a']) {
                return false;
            }
        }
        return n <= m;
    }
};