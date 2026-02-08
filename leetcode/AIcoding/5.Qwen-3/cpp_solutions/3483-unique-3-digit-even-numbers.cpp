#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> findEvenNumbers(int a, int b, int c) {
        vector<int> result;
        unordered_set<int> seen;
        for (int i = 0; i < 10; ++i) {
            for (int j = 0; j < 10; ++j) {
                for (int k = 0; k < 10; ++k) {
                    if (i != j && j != k && i != k && (k % 2 == 0)) {
                        int num = i * 100 + j * 10 + k;
                        if (num >= 100 && num <= 999) {
                            if (seen.find(num) == seen.end()) {
                                result.push_back(num);
                                seen.insert(num);
                            }
                        }
                    }
                }
            }
        }
        return result;
    }
};