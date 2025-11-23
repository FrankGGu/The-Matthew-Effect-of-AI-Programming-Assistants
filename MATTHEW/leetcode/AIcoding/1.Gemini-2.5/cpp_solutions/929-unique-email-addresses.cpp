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
            string cleanEmail = "";
            bool ignoreLocal = false;
            for (char c : email) {
                if (c == '+') {
                    ignoreLocal = true;
                } else if (c == '@') {
                    cleanEmail += c;
                    ignoreLocal = false;
                    while (cleanEmail.length() < email.length()) {
                        cleanEmail += email[cleanEmail.length()];
                    }
                    break;
                } else if (c == '.' && !ignoreLocal) {
                    continue;
                } else if (!ignoreLocal) {
                    cleanEmail += c;
                }
            }
            uniqueEmails.insert(cleanEmail);
        }
        return uniqueEmails.size();
    }
};