#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int distinctNumbersOnBoard(int n) {
        unordered_set<int> seen;
        int count = 0;
        for (int i = 1; i <= n; ++i) {
            int num = i;
            while (num > 0) {
                if (seen.find(num) == seen.end()) {
                    seen.insert(num);
                    ++count;
                }
                num /= 10;
            }
        }
        return count;
    }
};