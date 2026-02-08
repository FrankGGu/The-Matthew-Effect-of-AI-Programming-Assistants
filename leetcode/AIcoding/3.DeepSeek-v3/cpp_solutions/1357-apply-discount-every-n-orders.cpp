class Cashier {
private:
    int n;
    int discount;
    int current;
    unordered_map<int, int> prices;

public:
    Cashier(int n, int discount, vector<int>& products, vector<int>& prices) {
        this->n = n;
        this->discount = discount;
        this->current = 0;
        for (int i = 0; i < products.size(); ++i) {
            this->prices[products[i]] = prices[i];
        }
    }

    double getBill(vector<int> product, vector<int> amount) {
        current++;
        double total = 0;
        for (int i = 0; i < product.size(); ++i) {
            total += prices[product[i]] * amount[i];
        }
        if (current % n == 0) {
            total = total * (100 - discount) / 100;
        }
        return total;
    }
};