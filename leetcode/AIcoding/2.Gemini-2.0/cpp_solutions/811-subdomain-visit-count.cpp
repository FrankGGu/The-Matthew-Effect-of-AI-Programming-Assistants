#include <vector>
#include <string>
#include <sstream>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<string> subdomainVisits(vector<string>& cpdomains) {
        unordered_map<string, int> counts;
        for (string cpdomain : cpdomains) {
            int spacePos = cpdomain.find(" ");
            int count = stoi(cpdomain.substr(0, spacePos));
            string domain = cpdomain.substr(spacePos + 1);
            counts[domain] += count;

            int dotPos = domain.find(".");
            while (dotPos != string::npos) {
                domain = domain.substr(dotPos + 1);
                counts[domain] += count;
                dotPos = domain.find(".");
            }
        }

        vector<string> result;
        for (auto const& [domain, count] : counts) {
            result.push_back(to_string(count) + " " + domain);
        }
        return result;
    }
};