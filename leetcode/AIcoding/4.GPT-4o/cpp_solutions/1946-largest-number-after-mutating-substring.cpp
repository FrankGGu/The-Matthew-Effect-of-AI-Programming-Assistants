#include <string>
#include <algorithm>
using namespace std;

class Solution {
public:
    string maximumNumber(string num, vector<int>& change) {
        bool startChanging = false;
        for (int i = 0; i < num.size(); i++) {
            int digit = num[i] - '0';
            if (change[digit] > digit) {
                startChanging = true;
                num[i] = change[digit] + '0';
            } else if (change[digit] < digit && startChanging) {
                break;
            }
        }
        return num;
    }
};