#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int countGoodIntegers(string s) {
        int count = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s[i] == '0') {
                continue;
            }
            string numStr = "";
            while (i < s.length() && s[i] != '0') {
                numStr += s[i];
                i++;
            }
            if (numStr.length() > 0) {
                int num = stoi(numStr);
                if (num % 2 == 0) {
                    count++;
                }
            }
        }
        return count;
    }
};