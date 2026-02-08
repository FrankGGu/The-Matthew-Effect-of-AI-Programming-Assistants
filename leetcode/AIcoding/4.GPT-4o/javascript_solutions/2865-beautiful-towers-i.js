function beautifulTowers(nums) {
    const n = nums.length;
    let count = 0;

    for (let i = 0; i < n; i++) {
        let tower = new Set();
        tower.add(nums[i]);

        for (let j = i + 1; j < n; j++) {
            if (!tower.has(nums[j])) {
                tower.add(nums[j]);
                count++;
            }
        }
    }

    return count;
}