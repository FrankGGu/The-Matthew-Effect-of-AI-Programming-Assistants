class Solution {
    public String abbreviateProduct(int left, int right) {
        long product = 1;
        int count = 0;

        for (int i = left; i <= right; i++) {
            product *= i;
            while (product % 10 == 0) {
                product /= 10;
            }
            while (product >= 1000000000) {
                product /= 10;
                count++;
            }
        }

        StringBuilder result = new StringBuilder();
        if (count > 0) {
            result.append(product).append("e").append(count);
        } else {
            result.append(product);
        }

        return result.toString();
    }
}