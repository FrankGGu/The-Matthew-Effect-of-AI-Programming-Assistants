#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int trafficLight(int n, vector<vector<int>>& cars) {
        unordered_map<int, int> light;
        int result = 0;
        for (int i = 0; i < n; ++i) {
            int direction = cars[i][0];
            int turn = cars[i][1];
            if (turn == 0) {
                if (light.find(direction) == light.end()) {
                    result++;
                    light[direction] = 1;
                }
            } else {
                if (light.find(direction) == light.end() || light[direction] == 0) {
                    result++;
                    light[direction] = 1;
                } else {
                    result++;
                    light[direction] = 0;
                }
            }
        }
        return result;
    }
};