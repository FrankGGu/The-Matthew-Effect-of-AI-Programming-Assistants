#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int distributeCandies(vector<int>& candyType) {
        unordered_set<int> uniqueCandies;
        for (int type : candyType) {
            uniqueCandies.insert(type);
        }
        return min(uniqueCandies.size(), candyType.size() / 2);
    }
};