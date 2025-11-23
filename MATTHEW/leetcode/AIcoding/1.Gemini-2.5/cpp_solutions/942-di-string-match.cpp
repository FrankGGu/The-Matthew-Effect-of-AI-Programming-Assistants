#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    std::vector<int> diStringMatch(std::string s) {
        int n = s.length();
        int low = 0;
        int high = n;
        std::vector<int> result(n + 1);

        for (int i = 0; i < n; ++i) {
            if (s[i] == 'I') {
                result[i] = low++;
            } else {
                result[i] = high--;
            }
        }
        result[n] = low;

        return result;
    }
};