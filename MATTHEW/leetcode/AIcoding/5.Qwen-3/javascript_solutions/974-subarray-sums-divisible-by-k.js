function subarraysDivByK(nums, k) {
    const map = new Map();
    map.set(0, 1);
    let count = 0;
    let prefixSum = 0;
    for (let num of nums) {
        prefixSum += num;
        let rem = prefixSum % k;
        if (rem < 0) rem += k;
        if (map.has(rem)) {
            count += map.get(rem);
        }
        map.set(rem, (map.get(rem) || 0) + 1);
    }
    return count;
}