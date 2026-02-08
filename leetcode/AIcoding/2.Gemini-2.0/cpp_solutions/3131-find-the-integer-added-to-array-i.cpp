#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findTheValueOfTheIntegerAndItsReverse(int num) {
        int count = 0;
        for (int i = 1; i <= num; ++i) {
            string s = to_string(i);
            string reversed_s = s;
            reverse(reversed_s.begin(), reversed_s.end());
            if (s == reversed_s) {
                count++;
            }
        }
        return count;
    }
};