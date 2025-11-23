class Solution {
public:
    int minimumPushes(string word) {
        int count[26] = {0};
        for (char c : word) {
            count[c - 'a']++;
        }
        sort(count, count + 26, greater<int>());
        int res = 0;
        for (int i = 0; i < 26; ++i) {
            int pushes = (i / 8) + 1;
            res += pushes * count[i];
        }
        return res;
    }
};