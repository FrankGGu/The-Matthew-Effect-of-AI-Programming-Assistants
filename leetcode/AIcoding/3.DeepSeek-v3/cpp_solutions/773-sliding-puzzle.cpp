class Solution {
public:
    int slidingPuzzle(vector<vector<int>>& board) {
        string target = "123450";
        string start;
        for (int i = 0; i < 2; ++i) {
            for (int j = 0; j < 3; ++j) {
                start += to_string(board[i][j]);
            }
        }

        vector<vector<int>> dirs = {{1, 3}, {0, 2, 4}, {1, 5}, {0, 4}, {1, 3, 5}, {2, 4}};

        unordered_set<string> visited;
        queue<string> q;
        q.push(start);
        visited.insert(start);
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                string curr = q.front();
                q.pop();
                if (curr == target) {
                    return steps;
                }
                int zero = curr.find('0');
                for (int next : dirs[zero]) {
                    string nextStr = curr;
                    swap(nextStr[zero], nextStr[next]);
                    if (!visited.count(nextStr)) {
                        visited.insert(nextStr);
                        q.push(nextStr);
                    }
                }
            }
            ++steps;
        }

        return -1;
    }
};