#include <string>

using namespace std;

class Solution {
public:
    string generateTheString(int n) {
        string s(n, 'a');
        if (n % 2 == 0) {
            s[n - 1] = 'b';
        }
        return s;
    }
};