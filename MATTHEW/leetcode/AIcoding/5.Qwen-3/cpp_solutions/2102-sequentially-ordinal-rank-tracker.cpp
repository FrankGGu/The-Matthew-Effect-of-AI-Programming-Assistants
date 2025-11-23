#include <iostream>
#include <vector>
#include <map>
#include <set>

using namespace std;

class Solution {
public:
    vector<int> rankTracker(vector<string>& queries) {
        map<int, set<int>> rankToIds;
        map<int, int> idToRank;
        vector<int> result;

        for (const string& query : queries) {
            if (query[0] == 'A') {
                int id = stoi(query.substr(2));
                int rank = 1;
                while (rankToIds.find(rank) != rankToIds.end() && !rankToIds[rank].empty()) {
                    ++rank;
                }
                rankToIds[rank].insert(id);
                idToRank[id] = rank;
                result.push_back(rank);
            } else {
                int id = stoi(query.substr(2));
                int currentRank = idToRank[id];
                rankToIds[currentRank].erase(id);
                if (rankToIds[currentRank].empty()) {
                    rankToIds.erase(currentRank);
                }
                int nextRank = currentRank + 1;
                while (rankToIds.find(nextRank) != rankToIds.end() && !rankToIds[nextRank].empty()) {
                    ++nextRank;
                }
                rankToIds[nextRank].insert(id);
                idToRank[id] = nextRank;
                result.push_back(nextRank);
            }
        }

        return result;
    }
};