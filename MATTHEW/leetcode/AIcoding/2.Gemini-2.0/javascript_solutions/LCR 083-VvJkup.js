var permute = function(nums) {
    const result = [];

    function backtrack(current, remaining) {
        if (remaining.length === 0) {
            result.push([...current]);
            return;
        }

        for (let i = 0; i < remaining.length; i++) {
            const nextRemaining = remaining.slice(0, i).concat(remaining.slice(i + 1));
            current.push(remaining[i]);
            backtrack(current, nextRemaining);
            current.pop();
        }
    }

    backtrack([], nums);
    return result;
};