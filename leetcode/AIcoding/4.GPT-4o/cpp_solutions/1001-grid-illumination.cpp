class Solution {
public:
    vector<int> gridIllumination(int N, vector<vector<int>>& lamps, vector<vector<int>>& queries) {
        vector<int> result;
        unordered_set<string> lampSet;
        unordered_map<int, int> rowCount, colCount, diagCount, antiDiagCount;

        for (const auto& lamp : lamps) {
            int x = lamp[0], y = lamp[1];
            string pos = to_string(x) + "," + to_string(y);
            if (lampSet.insert(pos).second) {
                rowCount[x]++;
                colCount[y]++;
                diagCount[x - y]++;
                antiDiagCount[x + y]++;
            }
        }

        for (const auto& query : queries) {
            int x = query[0], y = query[1];
            if (rowCount[x] > 0 || colCount[y] > 0 || diagCount[x - y] > 0 || antiDiagCount[x + y] > 0) {
                result.push_back(1);
            } else {
                result.push_back(0);
            }
            for (int i = -1; i <= 1; ++i) {
                for (int j = -1; j <= 1; ++j) {
                    int newX = x + i, newY = y + j;
                    string pos = to_string(newX) + "," + to_string(newY);
                    if (lampSet.erase(pos)) {
                        rowCount[newX]--;
                        colCount[newY]--;
                        diagCount[newX - newY]--;
                        antiDiagCount[newX + newY]--;
                    }
                }
            }
        }

        return result;
    }
};