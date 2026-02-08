class Solution {
public:
    vector<int> blockPlacementQueries(int n, vector<vector<int>>& queries) {
        vector<int> result;
        vector<bool> placed(n + 1, false);
        int currentBlock = 1;

        for (const auto& query : queries) {
            int type = query[0];
            int x = query[1];

            if (type == 1) {
                if (!placed[x]) {
                    placed[x] = true;
                    currentBlock++;
                }
            } else {
                result.push_back(placed[x] ? currentBlock - 1 : currentBlock);
            }
        }

        return result;
    }
};