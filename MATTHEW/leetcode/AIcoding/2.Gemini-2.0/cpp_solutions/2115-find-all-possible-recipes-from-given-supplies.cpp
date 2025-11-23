#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <queue>

using namespace std;

class Solution {
public:
    vector<string> findAllRecipes(vector<string>& recipes, vector<vector<string>>& ingredients, vector<string>& supplies) {
        unordered_map<string, vector<string>> adj;
        unordered_map<string, int> inDegree;
        unordered_set<string> supplySet(supplies.begin(), supplies.end());

        for (const string& recipe : recipes) {
            inDegree[recipe] = 0;
        }

        for (int i = 0; i < recipes.size(); ++i) {
            for (const string& ingredient : ingredients[i]) {
                if (supplySet.find(ingredient) == supplySet.end()) {
                    adj[ingredient].push_back(recipes[i]);
                    inDegree[recipes[i]]++;
                }
            }
        }

        queue<string> q;
        for (const string& recipe : recipes) {
            if (inDegree[recipe] == 0) {
                q.push(recipe);
            }
        }

        vector<string> result;
        while (!q.empty()) {
            string recipe = q.front();
            q.pop();
            result.push_back(recipe);

            for (const string& neighbor : adj[recipe]) {
                inDegree[neighbor]--;
                if (inDegree[neighbor] == 0) {
                    q.push(neighbor);
                }
            }
        }

        vector<string> ans;
        for (const string& r : recipes) {
            bool found = false;
            for(const string& res : result){
                if(res == r){
                    found = true;
                    break;
                }
            }
            if(found) ans.push_back(r);
        }

        return ans;
    }
};