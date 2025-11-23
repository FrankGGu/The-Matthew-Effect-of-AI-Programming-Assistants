var numSquarefulPerms = function(nums) {
    nums.sort((a, b) => a - b);
    let count = 0;
    let used = new Array(nums.length).fill(false);

    function isPerfectSquare(num) {
        let sqrt = Math.sqrt(num);
        return sqrt === Math.floor(sqrt);
    }

    function permute(arr) {
        if (arr.length === nums.length) {
            count++;
            return;
        }

        for (let i = 0; i < nums.length; i++) {
            if (used[i] || (i > 0 && nums[i] === nums[i - 1] && !used[i - 1])) {
                continue;
            }

            if (arr.length > 0 && !isPerfectSquare(nums[i] + arr[arr.length - 1])) {
                continue;
            }

            used[i] = true;
            arr.push(nums[i]);
            permute(arr);
            arr.pop();
            used[i] = false;
        }
    }

    permute([]);
    return count;
};