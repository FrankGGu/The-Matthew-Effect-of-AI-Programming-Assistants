class Solution {
public:
    int domino(int N, vector<vector<int>>& A) {
        vector<int> board(2 * N, 0);
        for (const auto& domino : A) {
            board[domino[0]]++;
            board[domino[1]]++;
        }
        int totalPairs = 0;
        for (int count : board) {
            totalPairs += count / 2;
        }
        return totalPairs;
    }
};