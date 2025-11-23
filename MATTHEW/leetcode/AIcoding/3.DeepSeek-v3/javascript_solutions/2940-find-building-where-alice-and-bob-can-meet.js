var leftmostBuildingQueries = function(heights, queries) {
    const n = heights.length;
    const m = queries.length;
    const res = new Array(m).fill(-1);
    const qs = [];
    for (let i = 0; i < m; i++) {
        let a = queries[i][0], b = queries[i][1];
        if (a > b) [a, b] = [b, a];
        if (a === b || heights[a] < heights[b]) {
            res[i] = b;
        } else {
            qs.push([b, heights[a], i]);
        }
    }
    qs.sort((a, b) => a[0] - b[0]);
    const stack = [];
    let ptr = 0;
    for (let i = 0; i < n; i++) {
        while (stack.length && heights[stack[stack.length - 1]] < heights[i]) {
            stack.pop();
        }
        stack.push(i);
        while (ptr < qs.length && qs[ptr][0] === i) {
            const [pos, h, idx] = qs[ptr];
            let left = 0, right = stack.length - 1;
            let ans = -1;
            while (left <= right) {
                const mid = Math.floor((left + right) / 2);
                if (heights[stack[mid]] > h) {
                    ans = stack[mid];
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            res[idx] = ans;
            ptr++;
        }
    }
    return res;
};