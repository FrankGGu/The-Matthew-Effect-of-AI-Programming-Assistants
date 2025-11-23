class Solution {
public:
    int removeStones(vector<vector<int>>& stones) {
        unordered_map<int, int> rowMap, colMap;
        int n = stones.size();
        for (const auto& stone : stones) {
            rowMap[stone[0]]++;
            colMap[stone[1]]++;
        }

        int removableStones = 0;
        for (const auto& stone : stones) {
            removableStones += (rowMap[stone[0]] - 1) + (colMap[stone[1]] - 1);
            rowMap[stone[0]] = 0;
            colMap[stone[1]] = 0;
        }

        return removableStones;
    }
};