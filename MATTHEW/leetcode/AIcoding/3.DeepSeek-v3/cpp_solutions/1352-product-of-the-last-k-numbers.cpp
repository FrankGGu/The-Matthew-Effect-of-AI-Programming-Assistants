class ProductOfNumbers {
private:
    vector<int> prefixProducts;
    int lastZero;

public:
    ProductOfNumbers() {
        prefixProducts.push_back(1);
        lastZero = -1;
    }

    void add(int num) {
        if (num == 0) {
            prefixProducts.clear();
            prefixProducts.push_back(1);
            lastZero = prefixProducts.size() - 1;
        } else {
            prefixProducts.push_back(prefixProducts.back() * num);
        }
    }

    int getProduct(int k) {
        if (prefixProducts.size() - k - 1 <= lastZero) {
            return 0;
        }
        return prefixProducts.back() / prefixProducts[prefixProducts.size() - k - 1];
    }
};