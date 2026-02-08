#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int repeatedNTimes(vector<int>& A) {
        unordered_set<int> seen;
        for (int num : A) {
            if (seen.find(num) != seen.end()) {
                return num;
            }
            seen.insert(num);
        }
        return -1;
    }
};