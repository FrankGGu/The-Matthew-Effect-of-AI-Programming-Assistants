function possibleToSwap(nums, k) {
    const n = nums.length;
    const visited = new Array(n).fill(false);
    const result = [];

    function dfs(path) {
        if (path.length === n) {
            return true;
        }
        for (let i = 0; i < n; i++) {
            if (!visited[i]) {
                if (path.length > 0 && nums[i] < path[path.length - 1]) {
                    continue;
                }
                visited[i] = true;
                path.push(nums[i]);
                if (dfs(path)) {
                    return true;
                }
                path.pop();
                visited[i] = false;
            }
        }
        return false;
    }

    return dfs([]);
}

function makeLargestSpecial(s) {
    let count = 0, start = 0;
    const res = [];
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') count++;
        else count--;
        if (count === 0) {
            res.push('1' + makeLargestSpecial(s.substring(start + 1, i)) + '0');
            start = i + 1;
        }
    }
    res.sort((a, b) => b.localeCompare(a));
    return res.join('');
}

function smallestArray(nums, k) {
    const n = nums.length;
    const visited = new Array(n).fill(false);
    const result = [];

    function dfs(path) {
        if (path.length === n) {
            return [...path];
        }
        for (let i = 0; i < n; i++) {
            if (!visited[i]) {
                if (path.length > 0 && nums[i] < path[path.length - 1]) {
                    continue;
                }
                visited[i] = true;
                path.push(nums[i]);
                const temp = dfs(path);
                if (temp) {
                    return temp;
                }
                path.pop();
                visited[i] = false;
            }
        }
        return null;
    }

    return dfs([]);
}

function main() {
    const nums = [4, 3, 1, 2, 5];
    const k = 2;
    const result = smallestArray(nums, k);
    console.log(result);
}

main();