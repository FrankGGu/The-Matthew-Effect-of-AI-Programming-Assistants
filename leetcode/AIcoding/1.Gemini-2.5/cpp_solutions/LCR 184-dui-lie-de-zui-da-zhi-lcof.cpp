#include <vector>
#include <unordered_map>

class SelfCheckoutSystem {
private:
    std::unordered_map<int, int> productPrices;
    std::unordered_map<int, int> currentCart;
    long long currentTotal;

public:
    SelfCheckoutSystem(std::vector<std::vector<int>>& products) {
        for (const auto& product : products) {
            productPrices[product[0]] = product[1];
        }
        currentTotal = 0;
    }

    void addItem(int productId) {
        if (productPrices.count(productId)) {
            currentCart[productId]++;
            currentTotal += productPrices[productId];
        }
    }

    double getTotal() {
        return static_cast<double>(currentTotal);
    }

    void reset() {
        currentCart.clear();
        currentTotal = 0;
    }
};