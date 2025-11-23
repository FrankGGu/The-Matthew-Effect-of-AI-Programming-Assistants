#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string countAndSay(int n) {
        if (n <= 0) return "";
        string result = "1";
        for (int i = 1; i < n; ++i) {
            string temp;
            int count = 1;
            char current = result[0];
            for (int j = 1; j < result.length(); ++j) {
                if (result[j] == current) {
                    ++count;
                } else {
                    temp += to_string(count) + current;
                    current = result[j];
                    count = 1;
                }
            }
            temp += to_string(count) + current;
            result = temp;
        }
        return result;
    }
};