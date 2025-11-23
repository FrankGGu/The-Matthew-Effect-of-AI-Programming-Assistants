#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int maxUniqueSplit(string s) {
        unordered_set<string> seen;
        return backtrack(s, 0, seen);
    }

private:
    int backtrack(string s, int start, unordered_set<string>& seen) {
        if (start == s.length()) {
            return 0;
        }

        int max_count = -1;
        for (int i = start; i < s.length(); ++i) {
            string sub = s.substr(start, i - start + 1);
            if (seen.find(sub) == seen.end()) {
                seen.insert(sub);
                int count = 1 + backtrack(s, i + 1, seen);
                max_count = max(max_count, count);
                seen.erase(sub);
            }
        }

        return max_count;
    }
};