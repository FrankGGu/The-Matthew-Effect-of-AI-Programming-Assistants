#include <iostream>
#include <vector>
#include <string>
#include <map>

using namespace std;

class Solution {
public:
    string sortString(string s) {
        map<char, int> count;
        for (char c : s) {
            count[c]++;
        }

        string result;
        while (result.length() < s.length()) {
            for (char c = 'a'; c <= 'z'; ++c) {
                if (count[c] > 0) {
                    result += c;
                    count[c]--;
                }
            }
            for (char c = 'z'; c >= 'a'; --c) {
                if (count[c] > 0) {
                    result += c;
                    count[c]--;
                }
            }
        }
        return result;
    }
};