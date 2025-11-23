function permute(nums) {
    const result = [];

    function backtrack(path, remaining) {
        if (path.length === nums.length) {
            result.push([...path]);
            return;
        }

        for (let i = 0; i < remaining.length; i++) {
            path.push(remaining[i]);
            backtrack(path, remaining.slice(0, i).concat(remaining.slice(i + 1)));
            path.pop();
        }
    }

    backtrack([], nums);
    return result;
}