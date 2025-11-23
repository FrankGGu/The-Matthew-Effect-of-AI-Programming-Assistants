#include <vector>
#include <numeric> // Not strictly needed, but good practice for some operations

class Cashier {
public:
    Cashier(int n, int discount, std::vector<int>& products, std::vector<int>& prices) :
        n_(n),
        discount_(discount),
        order_count_(0)
    {
        product_prices_.resize(201); // Product IDs are 1 to 200.
        for (size_t i = 0; i < products.size(); ++i) {
            product_prices_[products[i]] = prices[i];
        }
    }

    double getBill(std::vector<int> product, std::vector<int> amount) {
        double current_bill = 0.0;
        for (size_t i = 0; i < product.size(); ++i) {
            current_bill += static_cast<double>(product_prices_[product[i]]) * amount[i];
        }

        order_count_++;

        if (order_count_ % n_ == 0) {
            current_bill *= (100.0 - discount_) / 100.0;
        }

        return current_bill;
    }

private:
    int n_;
    int discount_;
    std::vector<int> product_prices_;
    int order_count_;
};