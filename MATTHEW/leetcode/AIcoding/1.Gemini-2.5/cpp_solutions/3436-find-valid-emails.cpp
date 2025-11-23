#include <string>
#include <vector>
#include <regex>

using namespace std;

vector<string> findValidEmails(vector<string>& emails) {
    vector<string> result;
    regex pattern("^[a-zA-Z][a-zA-Z0-9_\\.\\-]*@leetcode\\.com$");
    for (const string& email : emails) {
        if (regex_match(email, pattern)) {
            result.push_back(email);
        }
    }
    return result;
}