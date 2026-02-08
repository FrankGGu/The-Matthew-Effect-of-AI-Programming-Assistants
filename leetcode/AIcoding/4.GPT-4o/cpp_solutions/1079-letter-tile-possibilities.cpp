class Solution {
public:
    int numTilePossibilities(string tiles) {
        unordered_set<string> uniqueCombinations;
        sort(tiles.begin(), tiles.end());
        generateCombinations(tiles, "", uniqueCombinations);
        return uniqueCombinations.size();
    }

    void generateCombinations(string tiles, string current, unordered_set<string>& uniqueCombinations) {
        if (!current.empty()) {
            uniqueCombinations.insert(current);
        }
        for (int i = 0; i < tiles.size(); ++i) {
            if (i > 0 && tiles[i] == tiles[i - 1]) continue;
            string nextTiles = tiles.substr(0, i) + tiles.substr(i + 1);
            generateCombinations(nextTiles, current + tiles[i], uniqueCombinations);
        }
    }
};