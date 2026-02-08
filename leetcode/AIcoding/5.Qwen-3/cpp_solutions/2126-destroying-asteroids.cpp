#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool asteroidsDestroyed(int mass, vector<int>& asteroids) {
        sort(asteroids.begin(), asteroids.end());
        for (int asteroid : asteroids) {
            if (mass < asteroid) {
                return false;
            }
            mass += asteroid;
        }
        return true;
    }
};