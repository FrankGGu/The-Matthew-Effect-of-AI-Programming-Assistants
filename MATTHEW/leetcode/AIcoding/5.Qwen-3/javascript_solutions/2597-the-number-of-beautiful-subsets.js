function beautifulSubsets(nums, k) {
    const count = new Map();
    for (const num of nums) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    const keys = Array.from(count.keys()).sort((a, b) => a - b);

    const dp = new Map();

    function dfs(i) {
        if (i === keys.length) return 1;
        const key = keys[i];
        const nextKey = key + k;
        const take = count.get(key) * dfs(i + 1);
        const skip = dfs(i + 1);
        return take + skip;
    }

    return dfs(0) - 1;
}