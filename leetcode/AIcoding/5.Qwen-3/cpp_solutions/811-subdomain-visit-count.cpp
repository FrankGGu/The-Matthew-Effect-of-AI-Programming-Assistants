#include <iostream>
#include <vector>
#include <map>
#include <sstream>

using namespace std;

class Solution {
public:
    vector<string> subdomainVisits(vector<string>& cpdomains) {
        map<string, int> domainMap;
        vector<string> result;

        for (const string& cpdomain : cpdomains) {
            size_t spacePos = cpdomain.find(' ');
            int count = stoi(cpdomain.substr(0, spacePos));
            string domain = cpdomain.substr(spacePos + 1);

            while (!domain.empty()) {
                domainMap[domain] += count;
                size_t dotPos = domain.find('.');
                if (dotPos == string::npos) break;
                domain = domain.substr(dotPos + 1);
            }
        }

        for (const auto& pair : domainMap) {
            result.push_back(to_string(pair.second) + " " + pair.first);
        }

        return result;
    }
};