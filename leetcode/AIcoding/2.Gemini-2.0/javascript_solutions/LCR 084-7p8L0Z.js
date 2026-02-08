var permuteUnique = function(nums) {
    const result = [];
    nums.sort((a, b) => a - b);

    const backtrack = (current, remaining, used) => {
        if (remaining.length === 0) {
            result.push([...current]);
            return;
        }

        for (let i = 0; i < remaining.length; i++) {
            if (i > 0 && remaining[i] === remaining[i - 1] && !used[i - 1]) {
                continue;
            }

            current.push(remaining[i]);
            used[i] = true;
            const nextRemaining = remaining.slice(0, i).concat(remaining.slice(i + 1));
            backtrack(current, nextRemaining, [...used]);
            used[i] = false;
            current.pop();
        }
    };

    backtrack([], nums, new Array(nums.length).fill(false));
    return result;
};