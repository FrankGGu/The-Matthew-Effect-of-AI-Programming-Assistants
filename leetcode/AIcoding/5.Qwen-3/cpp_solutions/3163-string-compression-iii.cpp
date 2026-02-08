#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string compressString(string str) {
        string result;
        int n = str.length();
        for (int i = 0; i < n; ) {
            char ch = str[i];
            int count = 0;
            while (i < n && str[i] == ch) {
                count++;
                i++;
            }
            result += ch;
            result += to_string(count);
        }
        return result;
    }
};