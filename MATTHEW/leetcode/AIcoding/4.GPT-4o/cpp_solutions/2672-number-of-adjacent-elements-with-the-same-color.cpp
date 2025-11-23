class Solution {
public:
    int colorTheArray(int n, vector<vector<int>>& queries) {
        vector<int> colors(n, 0);
        int adjacentCount = 0;
        vector<int> results;

        for (const auto& query : queries) {
            int index = query[0];
            int color = query[1];

            if (colors[index] != 0) {
                if (index > 0 && colors[index] == colors[index - 1]) adjacentCount--;
                if (index < n - 1 && colors[index] == colors[index + 1]) adjacentCount--;
            }

            colors[index] = color;

            if (index > 0 && colors[index] == colors[index - 1]) adjacentCount++;
            if (index < n - 1 && colors[index] == colors[index + 1]) adjacentCount++;

            results.push_back(adjacentCount);
        }

        return results;
    }
};