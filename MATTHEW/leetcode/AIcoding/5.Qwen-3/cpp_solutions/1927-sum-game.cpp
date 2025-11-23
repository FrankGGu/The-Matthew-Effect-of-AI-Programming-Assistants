#include <iostream>
#include <vector>
#include <string>
#include <cmath>

using namespace std;

class Solution {
public:
    bool sumGame(string a, string b) {
        int sumA = 0, sumB = 0;
        for (char c : a) {
            if (c != '_') {
                sumA += c - '0';
            }
        }
        for (char c : b) {
            if (c != '_') {
                sumB += c - '0';
            }
        }
        int countA = count(a.begin(), a.end(), '_');
        int countB = count(b.begin(), b.end(), '_');
        int total = countA + countB;
        int diff = sumA - sumB;
        return (diff == 0 && total % 2 == 0) || (diff != 0 && total % 2 == 1);
    }
};