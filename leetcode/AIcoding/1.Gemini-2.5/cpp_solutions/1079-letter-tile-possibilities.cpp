#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int count = 0;

    void dfs(const std::string& tiles, std::vector<bool>& visited, std::string& current_sequence) {
        if (!current_sequence.empty()) {
            count++;
        }

        for (int i = 0; i < tiles.length(); ++i) {
            if (visited[i]) {
                continue;
            }

            if (i > 0 && tiles[i] == tiles[i-1] && !visited[i-1]) {
                continue;
            }

            visited[i] = true;
            current_sequence.push_back(tiles[i]);

            dfs(tiles, visited, current_sequence);

            current_sequence.pop_back();
            visited[i] = false;
        }
    }

    int numTilePossibilities(std::string tiles) {
        std::sort(tiles.begin(), tiles.end());
        std::vector<bool> visited(tiles.length(), false);
        std::string current_sequence = "";

        dfs(tiles, visited, current_sequence);

        return count;
    }
};