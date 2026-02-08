#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    bool isLongPressedName(string name, string typed) {
        int i = 0, j = 0;
        while (i < name.size() && j < typed.size()) {
            if (name[i] != typed[j]) {
                return false;
            }
            char current = name[i];
            int countName = 0, countTyped = 0;
            while (i < name.size() && name[i] == current) {
                i++;
                countName++;
            }
            while (j < typed.size() && typed[j] == current) {
                j++;
                countTyped++;
            }
            if (countTyped < countName) {
                return false;
            }
        }
        return i == name.size() && j == typed.size();
    }
};