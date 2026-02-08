class Solution {
public:
    int largestVariance(string s) {
        int maxVariance = 0;
        unordered_set<char> chars(s.begin(), s.end());

        for (char a : chars) {
            for (char b : chars) {
                if (a == b) continue;

                int countA = 0, countB = 0;
                for (char c : s) {
                    if (c == a) countA++;
                    if (c == b) countB++;

                    if (countA < countB) {
                        countA = 0;
                        countB = 0;
                    }
                    if (countA > 0) {
                        maxVariance = max(maxVariance, countA - countB);
                    }
                }
            }
        }

        return maxVariance;
    }
};