class Solution {
public:
    vector<int> earliestFullMark(int n, vector<int>& marks) {
        vector<int> result(n, -1);
        int lastMark = -1;

        for (int i = 0; i < marks.size(); ++i) {
            if (marks[i] < n) {
                if (result[marks[i]] == -1) {
                    result[marks[i]] = i;
                }
            }
            lastMark = max(lastMark, marks[i]);
        }

        for (int i = 0; i < n; ++i) {
            if (result[i] == -1) {
                return {};
            }
        }
        return result;
    }
};