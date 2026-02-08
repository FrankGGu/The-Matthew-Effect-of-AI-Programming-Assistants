var volunteerDeployment = function(finalCnt, totalCnt, edges, plans) {
    const n = finalCnt.length;
    const m = plans.length;

    const adj = Array(n + 1).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const diff = Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        diff[i] = finalCnt[i - 1][0] - totalCnt[i - 1][0];
    }

    const ans = Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        ans[i] = "x";
    }

    const operations = [];
    for (let i = m - 1; i >= 0; i--) {
        const [type, center, val] = plans[i];
        operations.push([type, center, val]);
    }

    for (const [type, center, val] of operations) {
        if (type === 1) {
            diff[center] -= val;
        } else if (type === 2) {
            diff[center] += val * adj[center].length;
        } else if (type === 3) {
            for (const neighbor of adj[center]) {
                diff[neighbor] -= val;
            }
        }
    }

    let sum = 0;
    let count = 0;
    for (let i = 1; i <= n; i++) {
        if (adj[i].length === 0) {
            sum += diff[i];
            count++;
        }
    }

    let x;
    if (count > 0) {
        x = Math.round(sum / count);
    } else {
        let hasZeroDegree = false;
        for(let i = 1; i <= n; i++) {
            if(adj[i].length === 0) {
                hasZeroDegree = true;
                break;
            }
        }
        if(!hasZeroDegree) {
            x = 0;
        } else {
            x = 0;
        }

    }

    for (let i = 1; i <= n; i++) {
        ans[i] = x + diff[i];
    }

    return ans.slice(1);
};