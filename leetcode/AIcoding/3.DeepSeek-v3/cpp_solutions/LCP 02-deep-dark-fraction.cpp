class Solution {
public:
    vector<int> fraction(vector<int>& cont) {
        int n = cont.size();
        if (n == 0) return {0, 1};

        int numerator = cont[n-1];
        int denominator = 1;

        for (int i = n-2; i >= 0; --i) {
            int temp = numerator;
            numerator = denominator + cont[i] * numerator;
            denominator = temp;
        }

        return {numerator, denominator};
    }
};