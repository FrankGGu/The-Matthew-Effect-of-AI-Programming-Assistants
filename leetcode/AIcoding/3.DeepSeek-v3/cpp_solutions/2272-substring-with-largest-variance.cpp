class Solution {
public:
    int largestVariance(string s) {
        int res = 0;
        unordered_set<char> unique_chars(s.begin(), s.end());

        for (char a : unique_chars) {
            for (char b : unique_chars) {
                if (a == b) continue;

                int var = 0;
                bool has_b = false, first_b = false;

                for (char ch : s) {
                    if (ch == a) var++;
                    else if (ch == b) {
                        has_b = true;
                        if (first_b && var >= 0) {
                            first_b = false;
                        } else if (--var < 0) {
                            first_b = true;
                            var = -1;
                        }
                    }
                    if (has_b) res = max(res, var);
                }
            }
        }

        return res;
    }
};