#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minSwap(string s1, string s2) {
        int count1 = 0, count2 = 0;
        for (int i = 0; i < s1.length(); ++i) {
            if (s1[i] != s2[i]) {
                if (s1[i] == 'x') count1++;
                else count2++;
            }
        }
        if ((count1 + count2) % 2 != 0) return -1;
        return count1 / 2 + count2 / 2 + (count1 % 2);
    }
};