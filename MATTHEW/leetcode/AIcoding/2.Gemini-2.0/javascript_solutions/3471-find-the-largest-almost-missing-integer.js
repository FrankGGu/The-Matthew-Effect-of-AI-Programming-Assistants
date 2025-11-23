var findSmallestInteger = function(nums, m) {
    const seen = new Array(m).fill(0);
    for (const num of nums) {
        seen[((num % m) + m) % m]++;
    }
    let minIndex = 0;
    for (let i = 1; i < m; i++) {
        if (seen[i] < seen[minIndex]) {
            minIndex = i;
        }
    }
    return minIndex;
};