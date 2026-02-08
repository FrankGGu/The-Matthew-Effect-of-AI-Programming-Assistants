#include <string>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int numUniqueEmails(vector<string>& emails) {
        unordered_set<string> uniqueEmails;
        for (const string& email : emails) {
            string localName = "";
            string domainName = "";
            size_t atPos = email.find('@');
            if (atPos != string::npos) {
                localName = email.substr(0, atPos);
                domainName = email.substr(atPos + 1);
            }

            string processedLocalName = "";
            for (char c : localName) {
                if (c == '+') {
                    break;
                } else if (c != '.') {
                    processedLocalName += c;
                }
            }

            uniqueEmails.insert(processedLocalName + "@" + domainName);
        }
        return uniqueEmails.size();
    }
};