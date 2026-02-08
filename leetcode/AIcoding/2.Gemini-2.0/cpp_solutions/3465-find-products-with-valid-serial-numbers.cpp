#include <vector>
#include <string>

struct Products {
    std::string product_id;
    std::string product_name;
};

struct Valid_Serial {
    std::string product_id;
};

std::vector<Products> findProductsWithValidSerialNumbers(std::vector<Products>& products, std::vector<Valid_Serial>& valid_serial) {
    std::vector<Products> result;
    std::vector<std::string> valid_ids;
    for (auto& serial : valid_serial) {
        valid_ids.push_back(serial.product_id);
    }

    for (auto& product : products) {
        bool found = false;
        for (auto& id : valid_ids) {
            if (product.product_id == id) {
                found = true;
                break;
            }
        }
        if (found) {
            result.push_back(product);
        }
    }

    return result;
}