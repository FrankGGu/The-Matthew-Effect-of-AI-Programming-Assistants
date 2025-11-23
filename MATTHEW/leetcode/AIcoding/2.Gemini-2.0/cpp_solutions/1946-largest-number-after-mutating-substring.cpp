#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string maximumNumber(string num, vector<int>& change) {
        int n = num.size();
        bool changed = false;
        for (int i = 0; i < n; ++i) {
            int digit = num[i] - '0';
            if (change[digit] > digit) {
                num[i] = change[digit] + '0';
                changed = true;
            } else if (change[digit] < digit && changed) {
                break;
            } else if (change[digit] == digit && changed) {
                num[i] = change[digit] + '0';
            } else if (change[digit] < digit && !changed) {
                continue;
            }
        }
        return num;
    }
};