#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    double calculateTax(vector<vector<int>>& brackets, int income) {
        double tax = 0.0;
        int prev = 0;
        for (const auto& b : brackets) {
            int level = b[0];
            int percent = b[1];
            int amount = min(income, level) - prev;
            tax += amount * percent / 100.0;
            prev = level;
            if (income <= level) break;
        }
        return tax;
    }
};