#include <vector>
#include <numeric>

using namespace std;

class Cashier {
public:
    int n;
    int discount;
    vector<int> products;
    vector<int> prices;
    int customerCount;

    Cashier(int n, int discount, vector<int>& products, vector<int>& prices) : n(n), discount(discount), products(products), prices(prices), customerCount(0) {}

    double getBill(vector<int> product, vector<int> amount) {
        customerCount++;
        double total = 0.0;
        for (int i = 0; i < product.size(); ++i) {
            for (int j = 0; j < products.size(); ++j) {
                if (product[i] == products[j]) {
                    total += (double)prices[j] * amount[i];
                    break;
                }
            }
        }
        if (customerCount % n == 0) {
            total *= (100.0 - discount) / 100.0;
        }
        return total;
    }
};