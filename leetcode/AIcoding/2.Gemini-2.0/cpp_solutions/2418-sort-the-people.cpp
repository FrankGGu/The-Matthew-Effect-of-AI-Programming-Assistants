#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    vector<string> sortPeople(vector<string>& names, vector<int>& heights) {
        map<int, string> people;
        for (int i = 0; i < names.size(); ++i) {
            people[heights[i]] = names[i];
        }

        vector<string> sortedNames;
        for (auto it = people.rbegin(); it != people.rend(); ++it) {
            sortedNames.push_back(it->second);
        }

        return sortedNames;
    }
};