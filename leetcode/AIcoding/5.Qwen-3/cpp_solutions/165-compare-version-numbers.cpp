#include <iostream>
#include <vector>
#include <string>
#include <sstream>

using namespace std;

class Solution {
public:
    int compareVersionNumbers(string version1, string version2) {
        stringstream ss1(version1);
        stringstream ss2(version2);
        string part1, part2;
        while (getline(ss1, part1, '.') && getline(ss2, part2, '.')) {
            int num1 = stoi(part1);
            int num2 = stoi(part2);
            if (num1 > num2) return 1;
            if (num1 < num2) return -1;
        }
        while (getline(ss1, part1, '.')) {
            int num = stoi(part1);
            if (num > 0) return 1;
        }
        while (getline(ss2, part2, '.')) {
            int num = stoi(part2);
            if (num > 0) return -1;
        }
        return 0;
    }
};