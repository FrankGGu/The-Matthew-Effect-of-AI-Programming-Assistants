#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string strWithout3a3b(int a, int b) {
        string result;
        while (a > 0 || b > 0) {
            if (a > b) {
                result += 'a';
                a--;
                if (a > 0 && a > b) {
                    result += 'a';
                    a--;
                }
            } else {
                result += 'b';
                b--;
                if (b > 0 && b >= a) {
                    result += 'b';
                    b--;
                }
            }
        }
        return result;
    }
};