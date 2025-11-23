#include <iostream>
#include <vector>
#include <sstream>
#include <string>

using namespace std;

class Solution {
public:
    bool areNumbersAscending(string s) {
        istringstream iss(s);
        string token;
        int prev = -1;
        while (iss >> token) {
            if (isdigit(token[0])) {
                int num = stoi(token);
                if (num <= prev) {
                    return false;
                }
                prev = num;
            }
        }
        return true;
    }
};