class Solution {
public:
    double calculateTax(vector<vector<int>>& brackets, int income) {
        double tax = 0.0;
        int prev = 0;
        for (const auto& bracket : brackets) {
            int upper = bracket[0], percent = bracket[1];
            if (income <= prev) break;
            int taxable = min(upper, income) - prev;
            tax += taxable * percent / 100.0;
            prev = upper;
        }
        return tax;
    }
};