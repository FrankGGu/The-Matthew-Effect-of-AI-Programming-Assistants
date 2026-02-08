#include <vector>
#include <string>
#include <unordered_map>
#include <sstream>

using namespace std;

vector<string> subdomainVisits(vector<string>& cpdomains) {
    unordered_map<string, int> countMap;
    for (const string& domain : cpdomains) {
        istringstream ss(domain);
        int count;
        string domainPart;
        ss >> count >> domainPart;
        countMap[domainPart] += count;

        for (size_t pos = 0; (pos = domainPart.find('.')) != string::npos; ) {
            domainPart = domainPart.substr(pos + 1);
            countMap[domainPart] += count;
        }
    }

    vector<string> result;
    for (const auto& entry : countMap) {
        result.push_back(to_string(entry.second) + " " + entry.first);
    }
    return result;
}