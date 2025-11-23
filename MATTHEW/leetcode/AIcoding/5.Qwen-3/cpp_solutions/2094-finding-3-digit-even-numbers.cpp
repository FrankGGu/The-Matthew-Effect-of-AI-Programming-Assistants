#include <iostream>
#include <vector>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<int> findEvenNumbers(vector<int>& digits) {
        vector<int> result;
        unordered_set<int> seen;

        for (int i = 0; i < digits.size(); ++i) {
            if (digits[i] == 0) continue;
            for (int j = 0; j < digits.size(); ++j) {
                if (i == j) continue;
                for (int k = 0; k < digits.size(); ++k) {
                    if (i == k || j == k) continue;
                    int num = digits[i] * 100 + digits[j] * 10 + digits[k];
                    if (num % 2 == 0 && seen.find(num) == seen.end()) {
                        result.push_back(num);
                        seen.insert(num);
                    }
                }
            }
        }

        return result;
    }
};