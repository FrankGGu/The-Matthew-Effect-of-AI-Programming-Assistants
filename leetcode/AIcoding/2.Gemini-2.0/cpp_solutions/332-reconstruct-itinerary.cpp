#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<string> findItinerary(vector<vector<string>>& tickets) {
        unordered_map<string, multiset<string>> graph;
        for (const auto& ticket : tickets) {
            graph[ticket[0]].insert(ticket[1]);
        }

        vector<string> itinerary;
        string start = "JFK";
        stack<string> st;
        st.push(start);

        while (!st.empty()) {
            string current = st.top();
            if (graph[current].empty()) {
                itinerary.push_back(current);
                st.pop();
            } else {
                string next = *graph[current].begin();
                graph[current].erase(graph[current].begin());
                st.push(next);
            }
        }

        reverse(itinerary.begin(), itinerary.end());
        return itinerary;
    }
};