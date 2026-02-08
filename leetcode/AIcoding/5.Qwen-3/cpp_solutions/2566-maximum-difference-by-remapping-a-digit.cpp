#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int maxDiff(int num) {
        string s = to_string(num);
        string s1 = s;
        string s2 = s;

        for (int i = 0; i < s.size(); ++i) {
            if (s1[i] != '9') {
                char c = s1[i];
                for (int j = i; j < s1.size(); ++j) {
                    if (s1[j] == c) {
                        s1[j] = '9';
                    }
                }
                break;
            }
        }

        for (int i = 0; i < s.size(); ++i) {
            if (s2[i] != '1') {
                char c = s2[i];
                for (int j = i; j < s2.size(); ++j) {
                    if (s2[j] == c) {
                        s2[j] = '1';
                    }
                }
                break;
            }
        }

        return stoi(s1) - stoi(s2);
    }
};