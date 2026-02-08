var hitBricks = function(grid, hits) {
    const R = grid.length, C = grid[0].length;
    const dr = [0, 1, 0, -1];
    const dc = [1, 0, -1, 0];

    const A = new Array(R);
    for (let r = 0; r < R; ++r) {
        A[r] = [...grid[r]];
    }

    for (const [r, c] of hits) {
        A[r][c] = 0;
    }

    const parent = new Array(R * C + 1).fill(0).map((_, i) => i);
    const rank = new Array(R * C + 1).fill(1);

    function find(x) {
        if (parent[x] !== x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    function union(x, y) {
        let xr = find(x), yr = find(y);
        if (xr === yr) return;
        if (rank[xr] < rank[yr]) {
            [xr, yr] = [yr, xr];
        }
        parent[yr] = xr;
        rank[xr] += rank[yr];
    }

    const top = R * C;

    for (let r = 0; r < R; ++r) {
        for (let c = 0; c < C; ++c) {
            if (A[r][c] === 1) {
                const i = r * C + c;
                if (r === 0) {
                    union(i, top);
                }
                if (r > 0 && A[r-1][c] === 1) {
                    union(i, (r-1)*C + c);
                }
                if (c > 0 && A[r][c-1] === 1) {
                    union(i, r*C + c-1);
                }
            }
        }
    }

    const ans = new Array(hits.length).fill(0);

    for (let t = hits.length - 1; t >= 0; --t) {
        const [r, c] = hits[t];
        if (grid[r][c] === 0) continue;
        let pre = rank[find(top)];
        if (r === 0) {
            union(c, top);
        }
        for (let k = 0; k < 4; ++k) {
            const nr = r + dr[k];
            const nc = c + dc[k];
            if (0 <= nr && nr < R && 0 <= nc && nc < C && A[nr][nc] === 1) {
                union(r * C + c, nr * C + nc);
            }
        }
        A[r][c] = 1;
        const curr = rank[find(top)];
        ans[t] = Math.max(0, curr - pre - 1);
    }

    return ans;
};