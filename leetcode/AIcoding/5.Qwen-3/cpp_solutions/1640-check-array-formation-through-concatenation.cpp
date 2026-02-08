#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

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
            const vector<int>& currentPiece = pieceMap[arr[i]];
            for (int num : currentPiece) {
                if (i >= arr.size() || arr[i] != num) {
                    return false;
                }
                i++;
            }
        }
        return true;
    }
};