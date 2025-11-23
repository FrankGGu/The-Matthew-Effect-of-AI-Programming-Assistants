var countArrangement = function(n) {
    let count = 0;
    const nums = Array.from({ length: n }, (_, i) => i + 1);

    function permute(index) {
        if (index === n) {
            count++;
            return;
        }

        for (let i = index; i < n; i++) {
            [nums[index], nums[i]] = [nums[i], nums[index]];
            if (nums[index] % (index + 1) === 0 || (index + 1) % nums[index] === 0) {
                permute(index + 1);
            }
            [nums[index], nums[i]] = [nums[i], nums[index]];
        }
    }

    permute(0);
    return count;
};