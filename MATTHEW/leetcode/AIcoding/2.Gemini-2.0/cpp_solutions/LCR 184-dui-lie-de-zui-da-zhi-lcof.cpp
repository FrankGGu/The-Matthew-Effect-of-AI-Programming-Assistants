#include <vector>
#include <unordered_map>

using namespace std;

class CheckoutSystem {
public:
    CheckoutSystem() {

    }

    void add_item(int item_id, double price) {
        prices[item_id] = price;
    }

    void remove_item(int item_id) {
        prices.erase(item_id);
    }

    double get_price(int item_id) {
        if (prices.count(item_id)) {
            return prices[item_id];
        } else {
            return -1.0;
        }
    }

    void scan_item(int item_id) {
        if (prices.count(item_id)) {
            items.push_back(item_id);
        }
    }

    void remove_last_item() {
        if (!items.empty()) {
            items.pop_back();
        }
    }

    double calculate_total() {
        double total = 0.0;
        for (int item_id : items) {
            total += prices[item_id];
        }
        return total;
    }

    void apply_discount(double discount_percentage) {
        this->discount_percentage = discount_percentage;
    }

    double get_discounted_total() {
        double total = calculate_total();
        return total * (1.0 - discount_percentage / 100.0);
    }

private:
    unordered_map<int, double> prices;
    vector<int> items;
    double discount_percentage = 0.0;
};