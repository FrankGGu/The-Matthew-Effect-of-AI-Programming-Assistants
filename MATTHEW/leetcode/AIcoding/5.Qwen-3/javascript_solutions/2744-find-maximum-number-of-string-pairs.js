function maximumNumberOfStringPairs(nums) {
    const seen = new Set();
    let count = 0;

    for (const num of nums) {
        if (seen.has(num)) {
            count++;
            seen.delete(num);
        } else {
            seen.add(num);
        }
    }

    return count;
}