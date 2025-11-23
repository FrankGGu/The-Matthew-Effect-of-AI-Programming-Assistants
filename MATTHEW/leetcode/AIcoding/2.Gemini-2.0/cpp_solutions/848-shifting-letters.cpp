#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string shiftingLetters(string s, vector<int>& shifts) {
        long long shift_sum = 0;
        for (int i = shifts.size() - 1; i >= 0; --i) {
            shift_sum = (shift_sum + shifts[i]) % 26;
            s[i] = (s[i] - 'a' + shift_sum) % 26 + 'a';
        }
        return s;
    }
};