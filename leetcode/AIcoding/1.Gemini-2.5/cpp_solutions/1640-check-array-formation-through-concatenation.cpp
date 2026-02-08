#include <vector>
#include <map>

class Solution {
public:
    bool canFormArray(std::vector<int>& arr, std::vector<std::vector<int>>& pieces) {
        std::map<int, std::vector<int>> piece_map;
        int total_pieces_length = 0;

        for (const auto& piece : pieces) {
            if (!piece.empty()) {
                piece_map[piece[0]] = piece;
                total_pieces_length += piece.size();
            }
        }

        if (total_pieces_length != arr.size()) {
            return false;
        }

        int arr_idx = 0;
        while (arr_idx < arr.size()) {
            int current_val = arr[arr_idx];

            auto it = piece_map.find(current_val);
            if (it == piece_map.end()) {
                return false;
            }

            const std::vector<int>& current_piece = it->second;

            for (int i = 0; i < current_piece.size(); ++i) {
                if (arr[arr_idx + i] != current_piece[i]) {
                    return false;
                }
            }

            arr_idx += current_piece.size();
        }

        return true;
    }
};