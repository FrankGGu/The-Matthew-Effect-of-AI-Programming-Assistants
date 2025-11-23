function convertTo2DArray(nums, r, c) {
    if (nums.length !== r * c) return [];
    const result = [];
    for (let i = 0; i < r; i++) {
        result.push(nums.slice(i * c, (i + 1) * c));
    }
    return result;
}