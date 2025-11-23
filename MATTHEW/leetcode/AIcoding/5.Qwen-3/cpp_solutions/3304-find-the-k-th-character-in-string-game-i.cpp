#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    char kthCharacter(int n, int k) {
        string s = "a";
        while (s.length() < k) {
            string next;
            for (char c : s) {
                next += c;
                next += c;
            }
            s = next;
        }
        return s[k - 1];
    }
};