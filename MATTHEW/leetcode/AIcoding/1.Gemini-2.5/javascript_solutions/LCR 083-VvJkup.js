var permute = function(nums) {
    const result = [];
    const path = [];
    const visited = new Array(nums.length).fill(false);

    function backtrack() {
        if (path.length === nums.length) {
            result.push([...path]);
            return;
        }

        for (let i = 0; i < nums.length; i++) {
            if (visited[i]) {
                continue;
            }

            path.push(nums[i]);
            visited[i] = true;
            backtrack();
            visited[i] = false;
            path.pop();
        }
    }

    backtrack();
    return result;
};