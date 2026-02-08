#include <string>
#include <iostream>

using namespace std;

class Solution {
public:
    string countAndSay(int n) {
        if (n == 1) return "1";
        string prev = countAndSay(n - 1);
        string result = "";
        int count = 1;
        for (int i = 0; i < prev.length(); ++i) {
            if (i + 1 < prev.length() && prev[i] == prev[i + 1]) {
                count++;
            } else {
                result += to_string(count) + prev[i];
                count = 1;
            }
        }
        return result;
    }
};