function findMatrix(nums) {
    const freq = {};
    const result = [];

    for (const num of nums) {
        if (!freq[num]) {
            freq[num] = 0;
        }
        const row = freq[num];
        if (!result[row]) {
            result[row] = [];
        }
        result[row].push(num);
        freq[num]++;
    }

    return result;
}