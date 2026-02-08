class Solution {
public:
    vector<string> findAllRecipes(vector<string>& recipes, vector<vector<string>>& ingredients, vector<string>& supplies) {
        unordered_set<string> supplySet(supplies.begin(), supplies.end());
        unordered_map<string, vector<string>> recipeMap;
        unordered_map<string, int> indegree;
        vector<string> result;

        for (int i = 0; i < recipes.size(); i++) {
            indegree[recipes[i]] = ingredients[i].size();
            for (const auto& ing : ingredients[i]) {
                recipeMap[ing].push_back(recipes[i]);
            }
        }

        queue<string> q;
        for (const auto& supply : supplySet) {
            q.push(supply);
        }

        while (!q.empty()) {
            string current = q.front();
            q.pop();

            if (recipeMap.find(current) != recipeMap.end()) {
                for (const auto& recipe : recipeMap[current]) {
                    indegree[recipe]--;
                    if (indegree[recipe] == 0) {
                        result.push_back(recipe);
                        q.push(recipe);
                    }
                }
            }
        }

        return result;
    }
};