#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> separateSquares(vector<int>& nums) {
        vector<int> result;
        vector<int> squares;
        vector<int> nonSquares;

        for (int num : nums) {
            int root = sqrt(num);
            if (root * root == num) {
                squares.push_back(num);
            } else {
                nonSquares.push_back(num);
            }
        }

        result.insert(result.end(), squares.begin(), squares.end());
        result.insert(result.end(), nonSquares.begin(), nonSquares.end());

        return result;
    }
};