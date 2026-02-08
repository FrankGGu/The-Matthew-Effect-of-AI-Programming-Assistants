class Solution {
public:
    double calculateTax(vector<vector<int>>& brackets, int income) {
        double tax = 0.0;
        int prevLimit = 0;

        for (const auto& bracket : brackets) {
            int limit = bracket[0];
            int rate = bracket[1];
            if (income > prevLimit) {
                int taxableIncome = min(income, limit) - prevLimit;
                tax += taxableIncome * rate / 100.0;
                prevLimit = limit;
            } else {
                break;
            }
        }

        return tax;
    }
};