class Solution {
public:
    int numFriendRequests(vector<int>& ages) {
        vector<int> count(121, 0);
        for (int age : ages) {
            count[age]++;
        }

        int res = 0;
        for (int a = 1; a <= 120; ++a) {
            for (int b = 1; b <= 120; ++b) {
                if (b <= 0.5 * a + 7 || b > a || (b > 100 && a < 100)) {
                    continue;
                }
                res += count[a] * count[b];
                if (a == b) {
                    res -= count[a];
                }
            }
        }
        return res;
    }
};