class Solution {
public:
    int minimumChanges(string s) {
        int n = s.size();
        int ans = n;
        for (char c = 'a'; c <= 'z'; c++) {
            int changeCount1 = 0, changeCount2 = 0;
            for (char ch : s) {
                if (ch < c) changeCount1++;
                else if (ch > c) changeCount2++;
            }
            ans = min(ans, changeCount1 + changeCount2);
        }
        return ans;
    }
};