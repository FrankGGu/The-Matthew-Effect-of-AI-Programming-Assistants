class NeighborSumService {
    private int[] arr;
    private int size;

    public NeighborSumService(int[] nums) {
        this.arr = new int[nums.length];
        System.arraycopy(nums, 0, this.arr, 0, nums.length);
        this.size = nums.length;
    }

    public void update(int index, int val) {
        if (index >= 0 && index < size) {
            arr[index] = val;
        }
    }

    public int getNeighborSum(int index) {
        int sum = 0;
        if (index < 0 || index >= size) {
            return 0;
        }

        if (index - 1 >= 0) {
            sum += arr[index - 1];
        }

        if (index + 1 < size) {
            sum += arr[index + 1];
        }

        return sum;
    }
}