class Solution {
public:
    int numWays(string s) {
        int n = s.size();
        int ones = 0;
        for (char c : s) {
            if (c == '1') {
                ones++;
            }
        }

        if (ones % 3 != 0) {
            return 0;
        }

        if (ones == 0) {
            long long temp = n - 1;
            temp = temp * (temp - 1) / 2;
            return temp % 1000000007;
        }

        int target = ones / 3;
        int count1 = 0;
        long long firstCut = 0;
        for (int i = 0; i < n; i++) {
            if (s[i] == '1') {
                count1++;
            }
            if (count1 == target) {
                firstCut++;
            }
        }

        int count2 = 0;
        long long secondCut = 0;
        for (int i = 0; i < n; i++) {
            if (s[i] == '1') {
                count2++;
            }
            if (count2 == 2 * target) {
                secondCut++;
            }
        }

        return (firstCut * secondCut) % 1000000007;
    }
};