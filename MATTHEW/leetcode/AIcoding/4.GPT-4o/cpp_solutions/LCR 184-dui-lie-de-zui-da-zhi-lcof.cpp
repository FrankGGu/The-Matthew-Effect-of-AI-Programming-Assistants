class Cashier {
public:
    Cashier(int n, int discount, const vector<int>& products, const vector<int>& prices) {
        this->n = n;
        this->discount = discount;
        for (int i = 0; i < products.size(); ++i) {
            priceMap[products[i]] = prices[i];
        }
        customerCount = 0;
    }

    double getBill(const vector<int>& product, const vector<int>& amount) {
        double total = 0.0;
        for (int i = 0; i < product.size(); ++i) {
            total += priceMap[product[i]] * amount[i];
        }
        customerCount++;
        if (customerCount % n == 0) {
            total *= (100 - discount) / 100.0;
        }
        return total;
    }

private:
    unordered_map<int, int> priceMap;
    int n, discount, customerCount;
};