class Solution {
public:
    int findSubstringInWraproundString(string p) {
        vector<int> count(26, 0);
        int maxLen = 0;
        for (int i = 0; i < p.size(); ++i) {
            if (i > 0 && (p[i] - p[i-1] == 1 || p[i-1] - p[i] == 25)) {
                maxLen++;
            } else {
                maxLen = 1;
            }
            int index = p[i] - 'a';
            count[index] = max(count[index], maxLen);
        }
        return accumulate(count.begin(), count.end(), 0);
    }
};