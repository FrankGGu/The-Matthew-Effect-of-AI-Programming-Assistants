#include <vector>
#include <string>
#include <map>
#include <set>
#include <algorithm>
#include <stack>

class Solution {
public:
    std::map<std::string, std::multiset<std::string>> adj;
    std::vector<std::string> result;

    void dfs(std::string u) {
        while (!adj[u].empty()) {
            std::string v = *adj[u].begin();
            adj[u].erase(adj[u].begin());
            dfs(v);
        }
        result.push_back(u);
    }

    std::vector<std::string> findItinerary(std::vector<std::vector<std::string>>& tickets) {
        for (const auto& ticket : tickets) {
            adj[ticket[0]].insert(ticket[1]);
        }

        dfs("JFK");
        std::reverse(result.begin(), result.end());
        return result;
    }
};