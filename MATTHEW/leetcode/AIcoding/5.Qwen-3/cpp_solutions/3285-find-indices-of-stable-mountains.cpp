#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> stableMountains(vector<int>& height, int threshold) {
        vector<int> result;
        for (int i = 0; i < height.size(); ++i) {
            if (height[i] > threshold) {
                result.push_back(i);
            }
        }
        return result;
    }
};