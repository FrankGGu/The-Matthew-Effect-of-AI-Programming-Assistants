function wiggleSort(nums) {
    if (nums.length <= 1) return;

    const n = nums.length;
    const mid = Math.floor(n / 2);
    const temp = [...nums].sort((a, b) => a - b);

    let i = 1, j = mid + 1, k = 0;
    while (k < n) {
        if (k % 2 === 0) {
            nums[k] = temp[i++];
        } else {
            nums[k] = temp[j++];
        }
        k++;
    }
}