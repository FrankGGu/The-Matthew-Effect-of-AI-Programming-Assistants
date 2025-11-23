#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string convertDateToBinary(string date) {
        string result;
        vector<string> parts;
        string temp;
        for (char c : date) {
            if (c == '-') {
                parts.push_back(temp);
                temp.clear();
            } else {
                temp += c;
            }
        }
        parts.push_back(temp);

        for (int i = 0; i < parts.size(); ++i) {
            int num = stoi(parts[i]);
            string binary;
            if (num == 0) {
                binary = "0";
            } else {
                while (num > 0) {
                    binary = (num % 2 == 1 ? "1" : "0") + binary;
                    num /= 2;
                }
            }
            result += binary;
            if (i != parts.size() - 1) {
                result += "-";
            }
        }
        return result;
    }
};