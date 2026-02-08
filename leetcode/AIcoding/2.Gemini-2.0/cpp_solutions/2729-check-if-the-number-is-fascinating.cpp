#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool isFascinating(int n) {
        string s = to_string(n) + to_string(2 * n) + to_string(3 * n);
        if (s.length() != 9) return false;
        sort(s.begin(), s.end());
        return s == "123456789";
    }
};