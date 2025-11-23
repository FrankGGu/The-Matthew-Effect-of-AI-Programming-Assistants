#include <iostream>
#include <vector>

using namespace std;

class Solution {
private:
    vector<int> parkingSpaces;

public:
    Solution(int big, int medium, int small) {
        parkingSpaces = {big, medium, small};
    }

    bool addCar(int carType) {
        if (carType == 1 && parkingSpaces[0] > 0) {
            parkingSpaces[0]--;
            return true;
        } else if (carType == 2 && parkingSpaces[1] > 0) {
            parkingSpaces[1]--;
            return true;
        } else if (carType == 3 && parkingSpaces[2] > 0) {
            parkingSpaces[2]--;
            return true;
        }
        return false;
    }
};