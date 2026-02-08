#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<string> findWords(const string& words) {
        vector<string> result;
        unordered_set<char> row1 = {'q','w','e','r','t','y','u','i','o','p'};
        unordered_set<char> row2 = {'a','s','d','f','g','h','j','k','l'};
        unordered_set<char> row3 = {'z','x','c','v','b','n','m'};

        for (const string& word : words) {
            bool inRow1 = true, inRow2 = true, inRow3 = true;
            for (char c : word) {
                if (row1.find(tolower(c)) == row1.end()) inRow1 = false;
                if (row2.find(tolower(c)) == row2.end()) inRow2 = false;
                if (row3.find(tolower(c)) == row3.end()) inRow3 = false;
            }
            if (inRow1 || inRow2 || inRow3) {
                result.push_back(word);
            }
        }
        return result;
    }
};