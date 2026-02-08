class Solution {
public:
    vector<string> findItinerary(vector<vector<string>>& tickets) {
        unordered_map<string, multiset<string>> graph;
        for (const auto& ticket : tickets) {
            graph[ticket[0]].insert(ticket[1]);
        }
        vector<string> itinerary;
        stack<string> stk;
        stk.push("JFK");
        while (!stk.empty()) {
            string current = stk.top();
            if (graph[current].empty()) {
                itinerary.push_back(current);
                stk.pop();
            } else {
                auto next = graph[current].begin();
                stk.push(*next);
                graph[current].erase(next);
            }
        }
        reverse(itinerary.begin(), itinerary.end());
        return itinerary;
    }
};