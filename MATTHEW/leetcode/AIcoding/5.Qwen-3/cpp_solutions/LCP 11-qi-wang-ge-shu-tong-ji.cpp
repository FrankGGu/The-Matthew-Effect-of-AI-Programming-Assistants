#include <iostream>
#include <vector>
#include <map>

using namespace std;

class Solution {
public:
    int expectNumber(vector<int>& score) {
        map<int, int> count;
        for (int s : score) {
            count[s]++;
        }
        return count.size();
    }
};