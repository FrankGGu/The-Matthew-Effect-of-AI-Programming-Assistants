class Solution {
public:
    int minimumPushes(string word) {
        vector<int> freq(26, 0);
        for (char c : word) {
            freq[c - 'a']++;
        }
        sort(freq.rbegin(), freq.rend());
        int res = 0;
        for (int i = 0; i < 26; ++i) {
            int pushes = (i / 8) + 1;
            res += pushes * freq[i];
        }
        return res;
    }
};