class Solution {
public:
    int findChampion(int n, vector<vector<int>>& matches) {
        vector<int> outdegree(n + 1, 0);
        vector<int> indegree(n + 1, 0);

        for (const auto& match : matches) {
            outdegree[match[0]]++;
            indegree[match[1]]++;
        }

        int champion = -1;
        for (int i = 1; i <= n; i++) {
            if (outdegree[i] == 0 && indegree[i] == n - 1) {
                if (champion == -1) {
                    champion = i;
                } else {
                    return -1;
                }
            }
        }

        return champion;
    }
};