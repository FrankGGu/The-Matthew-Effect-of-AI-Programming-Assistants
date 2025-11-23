#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int kAvoidingArray(int n, int k) {
        unordered_set<int> used;
        int result = 0;
        int current = 1;

        while (n > 0) {
            if (used.find(current) == used.end()) {
                result += current;
                used.insert(current);
                n--;
            }
            current++;
        }

        return result;
    }
};