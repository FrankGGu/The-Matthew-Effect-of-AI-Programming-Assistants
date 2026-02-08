function frequencySort(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }
    return nums.sort((a, b) => {
        if (freq[a] !== freq[b]) {
            return freq[a] - freq[b];
        }
        return b - a;
    });
}