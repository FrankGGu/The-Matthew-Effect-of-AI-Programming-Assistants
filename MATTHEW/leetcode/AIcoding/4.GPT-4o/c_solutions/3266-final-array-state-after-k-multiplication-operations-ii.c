int[] finalArray(int[] nums, int k) {
    int n = nums.Length;
    int[] result = new int[n];
    for (int i = 0; i < n; i++) {
        result[i] = nums[i];
    }

    for (int i = 0; i < k; i++) {
        for (int j = 0; j < n; j++) {
            result[j] *= 2;
        }
    }

    return result;
}