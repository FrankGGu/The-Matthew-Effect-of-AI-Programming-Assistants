class Solution {
public:
    vector<vector<string>> fillMissingData(vector<vector<string>>& products) {
        unordered_map<string, unordered_map<string, string>> priceMap;
        unordered_map<string, unordered_map<string, string>> quantityMap;

        for (const auto& product : products) {
            string productName = product[0];
            string year = product[1];
            string price = product[2];
            string quantity = product[3];

            if (price != "NULL") {
                priceMap[productName][year] = price;
            }
            if (quantity != "NULL") {
                quantityMap[productName][year] = quantity;
            }
        }

        for (auto& product : products) {
            string productName = product[0];
            string year = product[1];
            string& price = product[2];
            string& quantity = product[3];

            if (price == "NULL") {
                if (priceMap[productName].count(year)) {
                    price = priceMap[productName][year];
                } else {
                    price = "0";
                }
            }
            if (quantity == "NULL") {
                if (quantityMap[productName].count(year)) {
                    quantity = quantityMap[productName][year];
                } else {
                    quantity = "0";
                }
            }
        }

        return products;
    }
};