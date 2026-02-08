#include <vector>
#include <string>
#include <regex>

using namespace std;

vector<string> findValidEmails(vector<string>& emails) {
    vector<string> result;
    regex pattern(R"(^[a-zA-Z][a-zA-Z0-9._-]*@leetcode\.com$)");

    for (const string& email : emails) {
        if (regex_match(email, pattern)) {
            result.push_back(email);
        }
    }

    return result;
}