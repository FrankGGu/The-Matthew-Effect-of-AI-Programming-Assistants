class Solution {
public:
    bool canFormArray(vector<int>& arr, vector<vector<int>>& pieces) {
        unordered_map<int, vector<int>> pieceMap;
        for (const auto& piece : pieces) {
            pieceMap[piece[0]] = piece;
        }

        for (int i = 0; i < arr.size();) {
            if (pieceMap.find(arr[i]) == pieceMap.end()) {
                return false;
            }
            auto& piece = pieceMap[arr[i]];
            for (int j = 0; j < piece.size(); ++j) {
                if (arr[i + j] != piece[j]) {
                    return false;
                }
            }
            i += piece.size();
        }

        return true;
    }
};