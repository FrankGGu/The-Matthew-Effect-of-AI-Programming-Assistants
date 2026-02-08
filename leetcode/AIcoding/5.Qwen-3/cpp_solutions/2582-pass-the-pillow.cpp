#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    int passThePillow(int n, int time) {
        int direction = 1;
        int current = 1;
        for (int i = 0; i < time; ++i) {
            current += direction;
            if (current == n || current == 1) {
                direction *= -1;
            }
        }
        return current;
    }
};