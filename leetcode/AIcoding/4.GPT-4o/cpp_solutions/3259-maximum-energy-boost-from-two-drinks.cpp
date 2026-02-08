class Solution {
public:
    int maxEnergyBoost(vector<int>& drinks) {
        int n = drinks.size();
        if (n < 2) return 0;

        sort(drinks.begin(), drinks.end(), greater<int>());
        return drinks[0] + drinks[1];
    }
};