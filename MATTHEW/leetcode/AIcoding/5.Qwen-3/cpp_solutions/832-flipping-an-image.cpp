#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> flipAndInvertImage(vector<vector<int>>& image) {
        for (auto& row : image) {
            int left = 0;
            int right = row.size() - 1;
            while (left < right) {
                swap(row[left], row[right]);
                left++;
                right--;
            }
            for (int i = 0; i < row.size(); ++i) {
                row[i] ^= 1;
            }
        }
        return image;
    }
};