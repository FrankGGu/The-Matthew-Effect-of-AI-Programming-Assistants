#include <string>
#include <unordered_set>
#include <vector>

using namespace std;

class Solution {
public:
    int numSplits(string s) {
        int n = s.size();
        vector<int> left(n, 0);
        vector<int> right(n, 0);

        unordered_set<char> leftSet;
        for (int i = 0; i < n; ++i) {
            leftSet.insert(s[i]);
            left[i] = leftSet.size();
        }

        unordered_set<char> rightSet;
        for (int i = n - 1; i >= 0; --i) {
            rightSet.insert(s[i]);
            right[i] = rightSet.size();
        }

        int count = 0;
        for (int i = 0; i < n - 1; ++i) {
            if (left[i] == right[i + 1]) {
                count++;
            }
        }

        return count;
    }
};