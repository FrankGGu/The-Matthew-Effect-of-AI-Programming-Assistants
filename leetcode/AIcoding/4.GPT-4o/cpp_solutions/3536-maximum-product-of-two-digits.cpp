class Solution {
public:
    int maxProduct(int n) {
        int max_product = 0;
        for (int i = 1; i <= n; i /= 10) {
            int digit1 = i % 10;
            int digit2 = n / i % 10;
            max_product = max(max_product, digit1 * digit2);
        }
        return max_product;
    }
};