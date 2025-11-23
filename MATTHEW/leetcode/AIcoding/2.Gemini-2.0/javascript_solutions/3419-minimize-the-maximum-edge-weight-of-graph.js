var minimizeMax = function(n, edges, k) {
    edges.sort((a, b) => a[2] - b[2]);
    let left = 1, right = 1000000000;
    let ans = right;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let count = 0;
        let parent = Array(n + 1).fill(0).map((_, i) => i);

        function find(x) {
            if (parent[x] !== x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        }

        function union(x, y) {
            let rootX = find(x);
            let rootY = find(y);
            if (rootX !== rootY) {
                parent[rootX] = rootY;
                return true;
            }
            return false;
        }

        for (let edge of edges) {
            if (edge[2] <= mid) {
                if (union(edge[0], edge[1])) {
                    count++;
                }
            }
        }

        if (count >= n - k) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
};