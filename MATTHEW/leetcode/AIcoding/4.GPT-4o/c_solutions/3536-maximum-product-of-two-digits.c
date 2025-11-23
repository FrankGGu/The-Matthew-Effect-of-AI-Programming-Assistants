int maxProduct(int n) {
    int max_product = 0;
    while (n > 0) {
        int digit1 = n % 10;
        int temp = n / 10;
        while (temp > 0) {
            int digit2 = temp % 10;
            int product = digit1 * digit2;
            if (product > max_product) {
                max_product = product;
            }
            temp /= 10;
        }
        n /= 10;
    }
    return max_product;
}