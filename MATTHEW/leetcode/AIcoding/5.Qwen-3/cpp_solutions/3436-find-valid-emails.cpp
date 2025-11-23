#include <iostream>
#include <vector>
#include <string>
#include <regex>

using namespace std;

class Solution {
public:
    vector<string> findValidEmails(const vector<string>& emails) {
        vector<string> result;
        regex pattern(R"([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})");
        for (const string& email : emails) {
            if (regex_match(email, pattern)) {
                result.push_back(email);
            }
        }
        return result;
    }
};