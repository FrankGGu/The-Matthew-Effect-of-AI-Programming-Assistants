function countPairs(nums, k) {
    const modCount = new Array(k).fill(0);
    let count = 0;

    for (const num of nums) {
        const mod = ((num % k) + k) % k;
        count += modCount[(k - mod) % k];
        modCount[mod]++;
    }

    return count;
}