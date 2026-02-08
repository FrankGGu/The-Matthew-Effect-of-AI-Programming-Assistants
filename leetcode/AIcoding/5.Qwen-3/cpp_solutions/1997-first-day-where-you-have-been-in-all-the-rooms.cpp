#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int firstDayBeenInAllRooms(vector<int>& arr) {
        unordered_map<int, int> map;
        int day = 0;
        for (int i = 0; i < arr.size(); ++i) {
            if (map.find(arr[i]) == map.end()) {
                map[arr[i]] = day;
            }
            day++;
        }
        return day - 1;
    }
};