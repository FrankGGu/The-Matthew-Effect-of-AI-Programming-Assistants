var numSquarefulPerms = function(nums) {
    let count = 0;
    const n = nums.length;

    function isSquare(x) {
        const s = Math.sqrt(x);
        return s === Math.floor(s);
    }

    function backtrack(start, path, used) {
        if (path.length === n) {
            count++;
            return;
        }

        for (let i = 0; i < n; i++) {
            if (used[i] || (i > 0 && nums[i] === nums[i - 1] && !used[i - 1])) continue;
            if (path.length > 0 && !isSquare(path[path.length - 1] + nums[i])) continue;

            used[i] = true;
            path.push(nums[i]);
            backtrack(i, path, used);
            path.pop();
            used[i] = false;
        }
    }

    nums.sort((a, b) => a - b);
    const used = new Array(n).fill(false);
    backtrack(0, [], used);
    return count;
};