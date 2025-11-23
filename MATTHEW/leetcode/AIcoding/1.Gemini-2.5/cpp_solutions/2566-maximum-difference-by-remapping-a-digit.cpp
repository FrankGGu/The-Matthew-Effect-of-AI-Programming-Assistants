#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minMaxDifference(int num) {
        string s = to_string(num);
        int n = s.length();

        char first_digit = s[0];
        int max_num = 0;
        int min_num = 0;

        string max_s = s;
        for (int i = 0; i < n; ++i) {
            if (max_s[i] == first_digit) {
                max_s[i] = '9';
            }
        }
        max_num = stoi(max_s);

        string min_s = s;
        for (int i = 0; i < n; ++i) {
            if (min_s[i] == first_digit) {
                min_s[i] = '0';
            }
        }
        min_num = stoi(min_s);

        return max_num - min_num;
    }
};