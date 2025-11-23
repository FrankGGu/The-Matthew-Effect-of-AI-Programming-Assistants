public class ProductOfTheLastKNumbers {
    private int[] nums;
    private int index;
    private long product;

    public ProductOfTheLastKNumbers() {
        nums = new int[10000];
        index = 0;
        product = 1;
    }

    public void add(int num) {
        nums[index++] = num;
        if (num != 0) {
            product *= num;
        } else {
            product = 1;
        }
    }

    public long getProduct(int k) {
        if (nums[index - k] == 0) {
            return 0;
        }
        long res = 1;
        for (int i = index - k; i < index; i++) {
            res *= nums[i];
        }
        return res;
    }
}