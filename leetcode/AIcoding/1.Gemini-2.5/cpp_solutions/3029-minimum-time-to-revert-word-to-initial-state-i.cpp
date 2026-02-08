#include <string>
#include <vector>

class Solution {
public:
    int minimumTimeToInitialState(std::string word, int k) {
        int n = word.length();
        for (int t = 1; t * k < n; ++t) {
            if (word.substr(t * k) == word.substr(0, n - t * k)) {
                return t;
            }
        }
        return (n + k - 1) / k;
    }
};