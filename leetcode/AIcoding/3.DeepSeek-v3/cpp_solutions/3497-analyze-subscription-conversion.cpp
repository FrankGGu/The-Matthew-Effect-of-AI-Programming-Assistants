#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> analyzeSubscriptionConversion(vector<string>& events) {
        unordered_map<string, unordered_set<string>> userToPages;
        unordered_map<string, unordered_set<string>> userToSubs;
        unordered_set<string> subPages;
        unordered_set<string> nonSubPages;

        for (const string& event : events) {
            vector<string> parts;
            size_t start = 0;
            size_t end = event.find(' ');
            while (end != string::npos) {
                parts.push_back(event.substr(start, end - start));
                start = end + 1;
                end = event.find(' ', start);
            }
            parts.push_back(event.substr(start));

            string user = parts[0];
            string action = parts[1];
            string page = parts[2];

            if (action == "PAGE_VIEW") {
                userToPages[user].insert(page);
            } else if (action == "SUBSCRIPTION") {
                userToSubs[user].insert(page);
            }
        }

        for (const auto& entry : userToSubs) {
            const string& user = entry.first;
            const unordered_set<string>& subs = entry.second;
            for (const string& sub : subs) {
                if (userToPages.find(user) != userToPages.end()) {
                    const unordered_set<string>& pages = userToPages[user];
                    if (pages.find(sub) != pages.end()) {
                        subPages.insert(sub);
                    } else {
                        nonSubPages.insert(sub);
                    }
                } else {
                    nonSubPages.insert(sub);
                }
            }
        }

        int subCount = subPages.size();
        int nonSubCount = nonSubPages.size();

        return {subCount, nonSubCount};
    }
};