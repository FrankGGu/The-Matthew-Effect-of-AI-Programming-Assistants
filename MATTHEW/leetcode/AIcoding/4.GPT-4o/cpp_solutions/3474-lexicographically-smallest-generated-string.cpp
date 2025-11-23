#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string generateString(int n) {
        string res(n, 'a');
        for (int i = 1; i < n; ++i) {
            if (i % 2 == 1) {
                res[i] = 'b';
            }
        }
        return res;
    }
};