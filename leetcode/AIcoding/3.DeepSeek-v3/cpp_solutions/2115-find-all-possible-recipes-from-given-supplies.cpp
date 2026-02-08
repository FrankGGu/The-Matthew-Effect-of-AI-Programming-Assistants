class Solution {
public:
    vector<string> findAllRecipes(vector<string>& recipes, vector<vector<string>>& ingredients, vector<string>& supplies) {
        unordered_map<string, vector<string>> graph;
        unordered_map<string, int> inDegree;
        unordered_set<string> supplySet(supplies.begin(), supplies.end());
        vector<string> result;

        for (int i = 0; i < recipes.size(); ++i) {
            string recipe = recipes[i];
            for (const string& ing : ingredients[i]) {
                graph[ing].push_back(recipe);
                inDegree[recipe]++;
            }
        }

        queue<string> q;
        for (const string& s : supplySet) {
            q.push(s);
        }

        while (!q.empty()) {
            string current = q.front();
            q.pop();

            for (const string& neighbor : graph[current]) {
                if (--inDegree[neighbor] == 0) {
                    q.push(neighbor);
                    result.push_back(neighbor);
                }
            }
        }

        return result;
    }
};