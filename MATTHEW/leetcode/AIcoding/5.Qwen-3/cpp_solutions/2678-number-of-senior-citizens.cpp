#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numSeniorCitizens(vector<string>& details) {
        int count = 0;
        for (const string& detail : details) {
            int age = stoi(detail.substr(11, 2));
            if (age >= 60) {
                count++;
            }
        }
        return count;
    }
};