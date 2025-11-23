function countPairs(nums, k) {
    const modCount = new Map();
    let result = 0;

    for (const num of nums) {
        const mod = num % k;
        const complement = (k - mod) % k;
        result += modCount.get(complement) || 0;
        modCount.set(mod, (modCount.get(mod) || 0) + 1);
    }

    return result;
}