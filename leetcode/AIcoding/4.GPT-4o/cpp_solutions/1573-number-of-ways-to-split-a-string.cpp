class Solution {
public:
    int numWays(string s) {
        int countOnes = 0;
        for (char c : s) {
            if (c == '1') countOnes++;
        }
        if (countOnes == 0) return (static_cast<long long>(s.size() - 1) * (s.size()) / 2) % 1000000007;
        if (countOnes % 3 != 0) return 0;

        int part = countOnes / 3;
        long long first = 0, second = 0, total = 0;

        for (int i = 0; i < s.size(); i++) {
            if (s[i] == '1') {
                if (total < part) {
                    total++;
                    if (total == 1) first = i;
                } else if (total == part) {
                    second++;
                }
            }
        }

        long long ways = 1;
        int count = 0;
        for (int i = first; i < s.size(); i++) {
            if (s[i] == '1') {
                count++;
                if (count == 1) {
                    ways *= second + 1;
                }
                if (count == part) {
                    break;
                }
            }
        }

        return ways % 1000000007;
    }
};