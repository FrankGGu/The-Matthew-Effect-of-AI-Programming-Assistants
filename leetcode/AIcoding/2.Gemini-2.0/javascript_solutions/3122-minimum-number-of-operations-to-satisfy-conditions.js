var minimumOperations = function(nums, conditions) {
    let n = nums.length;
    let adj = new Array(n).fill(null).map(() => []);
    let indegree = new Array(n).fill(0);

    for (let [a, b] of conditions) {
        adj[a].push(b);
        indegree[b]++;
    }

    let q = [];
    for (let i = 0; i < n; i++) {
        if (indegree[i] === 0) {
            q.push(i);
        }
    }

    let sorted = [];
    while (q.length > 0) {
        let u = q.shift();
        sorted.push(u);
        for (let v of adj[u]) {
            indegree[v]--;
            if (indegree[v] === 0) {
                q.push(v);
            }
        }
    }

    if (sorted.length !== n) {
        return -1;
    }

    let pos = new Array(n);
    for (let i = 0; i < n; i++) {
        pos[sorted[i]] = i;
    }

    let dp = [];
    for (let i = 0; i < n; i++) {
        let num = nums[i];
        let index = binarySearch(dp, num);
        if (index === dp.length) {
            dp.push(num);
        } else {
            dp[index] = num;
        }
    }

    return n - dp.length;

    function binarySearch(arr, target) {
        let left = 0;
        let right = arr.length;
        while (left < right) {
            let mid = Math.floor((left + right) / 2);
            if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
};