#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int numUniqueEmails(vector<string>& emails) {
        unordered_set<string> uniqueEmails;
        for (const string& email : emails) {
            string localName;
            bool atSymbolFound = false;
            for (char c : email) {
                if (c == '@') {
                    atSymbolFound = true;
                    localName += c;
                } else if (!atSymbolFound && c == '.') {
                    continue;
                } else if (!atSymbolFound && c == '+') {
                    atSymbolFound = true;
                } else if (!atSymbolFound) {
                    localName += c;
                }
            }
            uniqueEmails.insert(localName);
        }
        return uniqueEmails.size();
    }
};