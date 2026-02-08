#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countPoints(string s) {
        unordered_map<char, int> points;
        points['A'] = 4;
        points['K'] = 3;
        points['Q'] = 2;
        points['J'] = 1;
        points['T'] = 10;
        points['9'] = 0;
        points['8'] = 0;
        points['7'] = 0;

        int total = 0;
        for (int i = 0; i < s.length(); i += 3) {
            char rank = s[i];
            total += points[rank];
        }
        return total;
    }
};