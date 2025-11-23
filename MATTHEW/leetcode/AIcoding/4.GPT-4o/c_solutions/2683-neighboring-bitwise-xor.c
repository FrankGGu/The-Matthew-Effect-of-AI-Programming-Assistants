int[] findXOR(int[] nums) {
    int n = nums.Length;
    int[] result = new int[n];
    if (n == 0) return result;

    result[0] = nums[0] ^ nums[1];
    for (int i = 1; i < n - 1; i++) {
        result[i] = nums[i - 1] ^ nums[i] ^ nums[i + 1];
    }
    result[n - 1] = nums[n - 2] ^ nums[n - 1];

    return result;
}