#include <vector>

using namespace std;

class Solution {
public:
    double calculateTax(vector<vector<int>>& brackets, int income) {
        double tax = 0.0;
        int prev = 0;
        for (auto& bracket : brackets) {
            int upper = bracket[0];
            int percent = bracket[1];
            int taxable = min(income, upper) - prev;
            if (taxable > 0) {
                tax += (double)taxable * percent / 100.0;
            }
            prev = upper;
            if (income <= upper) {
                break;
            }
        }
        return tax;
    }
};