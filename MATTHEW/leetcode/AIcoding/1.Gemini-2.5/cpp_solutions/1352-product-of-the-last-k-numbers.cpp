#include <vector>

class ProductOfNumbers {
public:
    std::vector<long long> prefix_products;

    ProductOfNumbers() {
        prefix_products.push_back(1);
    }

    void add(int num) {
        if (num == 0) {
            prefix_products.clear();
            prefix_products.push_back(1);
        } else {
            prefix_products.push_back(prefix_products.back() * num);
        }
    }

    int getProduct(int k) {
        if (k >= prefix_products.size()) {
            return 0;
        } else {
            return static_cast<int>(prefix_products.back() / prefix_products[prefix_products.size() - 1 - k]);
        }
    }
};