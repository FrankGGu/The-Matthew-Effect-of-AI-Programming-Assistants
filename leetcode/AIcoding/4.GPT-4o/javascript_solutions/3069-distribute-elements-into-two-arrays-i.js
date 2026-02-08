function distributeArray(nums) {
    const n = nums.length / 2;
    const result = [new Array(n), new Array(n)];
    const count = {};

    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    let i = 0, j = 0;
    for (const num in count) {
        while (count[num] > 0 && i < n) {
            result[0][i++] = num;
            count[num]--;
        }
        while (count[num] > 0 && j < n) {
            result[1][j++] = num;
            count[num]--;
        }
    }

    return result;
}