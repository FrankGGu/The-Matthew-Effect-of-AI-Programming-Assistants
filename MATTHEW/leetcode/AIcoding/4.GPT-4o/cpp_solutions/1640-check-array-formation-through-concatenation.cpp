#include <vector>
#include <unordered_map>
#include <numeric>

class Solution {
public:
    bool canFormArray(std::vector<int>& arr, std::vector<std::vector<int>>& pieces) {
        std::unordered_map<int, std::vector<int>> pieceMap;
        for (const auto& piece : pieces) {
            pieceMap[piece[0]] = piece;
        }

        std::vector<int> result;
        for (int i = 0; i < arr.size();) {
            if (pieceMap.find(arr[i]) == pieceMap.end()) {
                return false;
            }
            const auto& piece = pieceMap[arr[i]];
            result.insert(result.end(), piece.begin(), piece.end());
            i += piece.size();
        }

        return result == arr;
    }
};