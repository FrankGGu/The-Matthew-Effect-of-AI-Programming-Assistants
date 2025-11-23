#include <vector>
#include <unordered_map>

using namespace std;

vector<vector<int>> groupThePeople(vector<int>& groupSizes) {
    unordered_map<int, vector<int>> groups;
    vector<vector<int>> result;

    for (int i = 0; i < groupSizes.size(); ++i) {
        groups[groupSizes[i]].push_back(i);
        if (groups[groupSizes[i]].size() == groupSizes[i]) {
            result.push_back(groups[groupSizes[i]]);
            groups.erase(groupSizes[i]);
        }
    }

    return result;
}