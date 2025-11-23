class Solution {
public:
    int shoppingOffers(vector<int>& price, vector<vector<int>>& special, vector<int>& needs) {
        return helper(price, special, needs, 0);
    }

private:
    int helper(vector<int>& price, vector<vector<int>>& special, vector<int>& needs, int pos) {
        int minCost = directPurchase(price, needs);
        for (int i = pos; i < special.size(); i++) {
            vector<int> offer = special[i];
            vector<int> tempNeeds;
            bool isValid = true;
            for (int j = 0; j < needs.size(); j++) {
                if (needs[j] < offer[j]) {
                    isValid = false;
                    break;
                }
            }
            if (isValid) {
                for (int j = 0; j < needs.size(); j++) {
                    tempNeeds.push_back(needs[j] - offer[j]);
                }
                minCost = min(minCost, offer.back() + helper(price, special, tempNeeds, i));
            }
        }
        return minCost;
    }

    int directPurchase(vector<int>& price, vector<int>& needs) {
        int total = 0;
        for (int i = 0; i < price.size(); i++) {
            total += price[i] * needs[i];
        }
        return total;
    }
};