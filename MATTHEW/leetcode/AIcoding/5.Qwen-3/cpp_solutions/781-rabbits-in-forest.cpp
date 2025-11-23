#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numRabbits(int n, vector<int>& answers) {
        unordered_map<int, int> count;
        int result = 0;
        for (int ans : answers) {
            if (count[ans] == 0) {
                result += ans + 1;
                count[ans] = ans;
            } else {
                count[ans]--;
            }
        }
        return result;
    }
};