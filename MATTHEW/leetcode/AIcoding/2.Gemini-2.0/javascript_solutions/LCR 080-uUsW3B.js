var combine = function(n, k) {
    const result = [];
    const backtrack = (start, combination) => {
        if (combination.length === k) {
            result.push([...combination]);
            return;
        }

        for (let i = start; i <= n; i++) {
            combination.push(i);
            backtrack(i + 1, combination);
            combination.pop();
        }
    };

    backtrack(1, []);
    return result;
};