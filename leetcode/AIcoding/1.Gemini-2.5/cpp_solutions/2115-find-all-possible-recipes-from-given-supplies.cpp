#include <vector>
#include <string>
#include <map>
#include <queue>
#include <set> // Not strictly needed, but could be useful for unique names if not using map

class Solution {
public:
    std::vector<std::string> findAllRecipes(std::vector<std::string>& recipes, std::vector<std::vector<std::string>>& ingredients, std::vector<std::string>& supplies) {
        std::map<std::string, int> name_to_id;
        std::vector<std::string> id_to_name;
        int next_id = 0;

        // Helper to get ID for a string, assigning a new one if not seen
        // and expanding id_to_name.
        auto get_id = [&](const std::string& name) {
            if (name_to_id.find(name) == name_to_id.end()) {
                name_to_id[name] = next_id++;
                id_to_name.push_back(name); // Ensure id_to_name grows with next_id
            }
            return name_to_id[name];
        };

        // Assign IDs for all recipes
        for (const std::string& recipe_name : recipes) {
            get_id(recipe_name);
        }

        // Assign IDs for all ingredients and supplies
        for (const auto& ingredient_list : ingredients) {
            for (const std::string& ingredient_name : ingredient_list) {
                get_id(ingredient_name);
            }
        }
        for (const std::string& supply_name : supplies) {
            get_id(supply_name);
        }

        int total_nodes = next_id;
        std::vector<int> in_degree(total_nodes, 0);
        std::vector<std::vector<int>> adj(total_nodes); // adj[ingredient_id] -> list of recipes that need it
        std::vector<bool> is_recipe_node(total_nodes, false);

        // Mark recipe nodes
        for (const std::string& recipe_name : recipes) {
            is_recipe_node[name_to_id[recipe_name]] = true;
        }

        // Build graph and calculate in-degrees for recipes
        for (int i = 0; i < recipes.size(); ++i) {
            int recipe_id = name_to_id[recipes[i]];
            for (const std::string& ingredient_name : ingredients[i]) {
                int ingredient_id = name_to_id[ingredient_name];
                adj[ingredient_id].push_back(recipe_id);
                in_degree[recipe_id]++;
            }
        }

        // Initialize queue with initial supplies
        std::queue<int> q;
        for (const std::string& supply_name : supplies) {
            int supply_id = name_to_id[supply_name];
            q.push(supply_id);
        }

        std::vector<std::string> result_recipes;

        // Perform topological sort (Kahn's algorithm)
        while (!q.empty()) {
            int u = q.front();
            q.pop();

            if (is_recipe_node[u]) {
                result_recipes.push_back(id_to_name[u]);
            }

            // For all recipes that depend on 'u'
            for (int v : adj[u]) {
                in_degree[v]--;
                if (in_degree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return result_recipes;
    }
};