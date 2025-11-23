var permute = function(nums) {
    const result = [];
    const backtrack = (path) => {
        if (path.length === nums.length) {
            result.push([...path]);
            return;
        }
        for (let num of nums) {
            if (path.includes(num)) continue;
            path.push(num);
            backtrack(path);
            path.pop();
        }
    };
    backtrack([]);
    return result;
};