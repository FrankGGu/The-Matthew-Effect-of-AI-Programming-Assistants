class Cashier {
public:
    Cashier(int n, int discount, const vector<int>& products, const vector<int>& prices) {
        this->n = n;
        this->discount = discount;
        for (int i = 0; i < products.size(); ++i) {
            productPrice[products[i]] = prices[i];
        }
        count = 0;
    }

    double getBill(const vector<int>& product, const vector<int>& amount) {
        double total = 0;
        for (int i = 0; i < product.size(); ++i) {
            total += productPrice[product[i]] * amount[i];
        }
        count++;
        if (count % n == 0) {
            total *= (100 - discount) / 100.0;
        }
        return total;
    }

private:
    int n;
    int discount;
    int count;
    unordered_map<int, int> productPrice;
};