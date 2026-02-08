#include <string>

using namespace std;

class Solution {
public:
    long long countSubstrings(string word) {
        long long n = word.size();
        long long count = 0;
        for (int i = 0; i < n; ++i) {
            if ((word[i] - '0') % 2 == 0) {
                count += (i + 1);
            }
        }
        return count;
    }
};