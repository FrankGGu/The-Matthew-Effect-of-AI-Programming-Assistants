#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <stack>

using namespace std;

class Solution {
public:
    vector<string> findItinerary(vector<vector<string>>& tickets) {
        map<string, vector<string>> graph;
        for (const auto& ticket : tickets) {
            graph[ticket[0]].push_back(ticket[1]);
        }

        for (auto& pair : graph) {
            sort(pair.second.begin(), pair.second.end());
        }

        vector<string> result;
        stack<string> s;
        s.push("JFK");

        while (!s.empty()) {
            string current = s.top();
            if (graph[current].empty()) {
                result.push_back(current);
                s.pop();
            } else {
                string next = graph[current].back();
                graph[current].pop_back();
                s.push(next);
            }
        }

        reverse(result.begin(), result.end());
        return result;
    }
};