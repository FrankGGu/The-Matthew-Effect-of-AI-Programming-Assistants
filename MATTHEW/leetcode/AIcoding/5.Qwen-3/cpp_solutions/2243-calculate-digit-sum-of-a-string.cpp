#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string digitSum(string s, int k) {
        while (s.length() > k) {
            string new_s;
            for (int i = 0; i < s.length(); i += k) {
                int sum = 0;
                for (int j = 0; j < k && i + j < s.length(); ++j) {
                    sum += s[i + j] - '0';
                }
                new_s += to_string(sum);
            }
            s = new_s;
        }
        return s;
    }
};