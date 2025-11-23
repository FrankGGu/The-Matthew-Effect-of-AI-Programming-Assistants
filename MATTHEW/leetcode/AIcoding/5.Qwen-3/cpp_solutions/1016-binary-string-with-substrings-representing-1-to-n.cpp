#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool canConstruct(string s, int n) {
        int len = s.length();
        for (int i = 1; i <= n; ++i) {
            string substr = "";
            int num = i;
            while (num > 0) {
                substr = to_string(num % 2) + substr;
                num /= 2;
            }
            if (s.find(substr) == string::npos) {
                return false;
            }
        }
        return true;
    }
};