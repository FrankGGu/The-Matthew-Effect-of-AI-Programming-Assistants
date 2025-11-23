#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numStrings(vector<string>& patterns, string word) {
        int count = 0;
        for (const string& p : patterns) {
            if (word.find(p) != string::npos) {
                count++;
            }
        }
        return count;
    }
};