class Solution {
public:
    int findMinimumOperations(string s1, string s2, string s3) {
        int n1 = s1.size(), n2 = s2.size(), n3 = s3.size();
        int minLen = min({n1, n2, n3});
        int common = 0;
        for (int i = 0; i < minLen; ++i) {
            if (s1[i] == s2[i] && s2[i] == s3[i]) {
                common++;
            } else {
                break;
            }
        }
        if (common == 0) return -1;
        return (n1 - common) + (n2 - common) + (n3 - common);
    }
};