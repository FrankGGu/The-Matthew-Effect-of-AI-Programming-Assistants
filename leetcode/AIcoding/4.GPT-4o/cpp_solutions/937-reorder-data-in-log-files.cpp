#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> reorderLogs(vector<string>& logs) {
        vector<string> letterLogs, digitLogs;

        for (const string& log : logs) {
            if (isdigit(log[log.find(' ') + 1])) {
                digitLogs.push_back(log);
            } else {
                letterLogs.push_back(log);
            }
        }

        sort(letterLogs.begin(), letterLogs.end(), [](const string& a, const string& b) {
            int spaceA = a.find(' '), spaceB = b.find(' ');
            string identifierA = a.substr(0, spaceA);
            string contentA = a.substr(spaceA + 1);
            string identifierB = b.substr(0, spaceB);
            string contentB = b.substr(spaceB + 1);
            if (contentA == contentB) {
                return identifierA < identifierB;
            }
            return contentA < contentB;
        });

        letterLogs.insert(letterLogs.end(), digitLogs.begin(), digitLogs.end());
        return letterLogs;
    }
};