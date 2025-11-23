class Solution {
public:
    string abbreviateProduct(int left, int right) {
        long long product = 1;
        int count = 0;
        for (int i = left; i <= right; ++i) {
            product *= i;
            while (product % 10 == 0) {
                product /= 10;
            }
            while (product >= 100000) {
                product /= 10;
            }
        }
        string result = to_string(product);
        if (result.length() > 10) {
            result = result.substr(0, 10);
        }
        return result + "e" + to_string(right - left + 1);
    }
};