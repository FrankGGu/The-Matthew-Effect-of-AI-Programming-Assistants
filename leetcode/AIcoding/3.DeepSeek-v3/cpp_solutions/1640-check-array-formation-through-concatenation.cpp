class Solution {
public:
    bool canFormArray(vector<int>& arr, vector<vector<int>>& pieces) {
        unordered_map<int, vector<int>> pieceMap;
        for (const auto& piece : pieces) {
            pieceMap[piece[0]] = piece;
        }

        int i = 0;
        while (i < arr.size()) {
            if (pieceMap.find(arr[i]) == pieceMap.end()) {
                return false;
            }
            const vector<int>& piece = pieceMap[arr[i]];
            for (int num : piece) {
                if (num != arr[i]) {
                    return false;
                }
                i++;
            }
        }
        return true;
    }
};