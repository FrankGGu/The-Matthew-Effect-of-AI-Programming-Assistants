#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int minChanges(string s) {
        int count1 = 0, count2 = 0;
        for (int i = 0; i < s.size(); ++i) {
            if (i % 2 == 0) {
                if (s[i] != '0') count1++;
                if (s[i] != '1') count2++;
            } else {
                if (s[i] != '1') count1++;
                if (s[i] != '0') count2++;
            }
        }
        return min(count1, count2);
    }
};