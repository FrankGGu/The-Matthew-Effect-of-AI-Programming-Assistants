#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> reorderLogFiles(vector<string>& logs) {
        vector<string> letterLogs;
        vector<string> digitLogs;

        for (const string& log : logs) {
            size_t spacePos = log.find(' ');
            if (spacePos != string::npos && isdigit(log[spacePos + 1])) {
                digitLogs.push_back(log);
            } else {
                letterLogs.push_back(log);
            }
        }

        sort(letterLogs.begin(), letterLogs.end(), [](const string& a, const string& b) {
            size_t spacePosA = a.find(' ');
            size_t spacePosB = b.find(' ');

            string identifierA = a.substr(0, spacePosA);
            string identifierB = b.substr(0, spacePosB);

            string contentA = a.substr(spacePosA + 1);
            string contentB = b.substr(spacePosB + 1);

            if (contentA == contentB) {
                return identifierA < identifierB;
            } else {
                return contentA < contentB;
            }
        });

        vector<string> result = letterLogs;
        result.insert(result.end(), digitLogs.begin(), digitLogs.end());

        return result;
    }
};