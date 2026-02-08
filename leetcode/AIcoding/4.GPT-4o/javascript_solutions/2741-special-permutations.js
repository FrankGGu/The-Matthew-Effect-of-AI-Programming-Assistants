var specialPerm = function(nums) {
    const n = nums.length;
    const visited = new Array(n).fill(false);
    let count = 0;

    const backtrack = (perm) => {
        if (perm.length === n) {
            count++;
            return;
        }
        for (let i = 0; i < n; i++) {
            if (!visited[i] && (perm.length === 0 || gcd(perm[perm.length - 1], nums[i]) === 1)) {
                visited[i] = true;
                perm.push(nums[i]);
                backtrack(perm);
                perm.pop();
                visited[i] = false;
            }
        }
    };

    const gcd = (a, b) => {
        while (b) {
            [a, b] = [b, a % b];
        }
        return a;
    };

    backtrack([]);
    return count;
};