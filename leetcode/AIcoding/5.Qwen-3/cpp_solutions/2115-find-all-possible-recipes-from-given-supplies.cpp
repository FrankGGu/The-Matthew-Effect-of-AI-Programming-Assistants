#include <iostream>
#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> findAllRecipes(vector<string>& recipes, vector<vector<string>>& ingredients, vector<string>& supplies) {
        unordered_map<string, int> recipeIndex;
        for (int i = 0; i < recipes.size(); ++i) {
            recipeIndex[recipes[i]] = i;
        }

        unordered_map<string, vector<string>> graph;
        vector<int> inDegree(recipes.size(), 0);

        for (int i = 0; i < ingredients.size(); ++i) {
            for (const string& ingredient : ingredients[i]) {
                if (recipeIndex.find(ingredient) != recipeIndex.end()) {
                    graph[ingredient].push_back(recipes[i]);
                    inDegree[i]++;
                }
            }
        }

        queue<int> q;
        unordered_set<string> supplySet(supplies.begin(), supplies.end());

        for (int i = 0; i < recipes.size(); ++i) {
            if (inDegree[i] == 0) {
                q.push(i);
            }
        }

        vector<int> result;

        while (!q.empty()) {
            int current = q.front();
            q.pop();
            result.push_back(current);

            for (const string& nextRecipe : graph[recipes[current]]) {
                int index = recipeIndex[nextRecipe];
                inDegree[index]--;
                if (inDegree[index] == 0) {
                    q.push(index);
                }
            }
        }

        return result;
    }
};