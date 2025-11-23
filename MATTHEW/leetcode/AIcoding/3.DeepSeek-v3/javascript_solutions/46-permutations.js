var permute = function(nums) {
    const result = [];

    const backtrack = (current, remaining) => {
        if (remaining.length === 0) {
            result.push([...current]);
            return;
        }

        for (let i = 0; i < remaining.length; i++) {
            current.push(remaining[i]);
            const newRemaining = remaining.slice(0, i).concat(remaining.slice(i + 1));
            backtrack(current, newRemaining);
            current.pop();
        }
    };

    backtrack([], nums);
    return result;
};