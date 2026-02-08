class Solution {
public:
    vector<int> cycleLengthQueries(int n, vector<vector<int>>& queries) {
        vector<int> result;
        for (const auto& query : queries) {
            int x = query[0], y = query[1];
            int length = 0;

            while (x != y) {
                if (x > y) {
                    x /= 2;
                } else {
                    y /= 2;
                }
                length++;
            }
            result.push_back(length + 1);
        }
        return result;
    }
};