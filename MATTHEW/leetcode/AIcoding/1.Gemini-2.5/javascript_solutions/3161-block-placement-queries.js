var blockPlacementQueries = function(blocks, queries) {
    const allCoords = new Set();
    for (const [pos, size] of blocks) {
        allCoords.add(pos);
        allCoords.add(pos + size - 1);
    }
    for (const [pos, size, id] of queries) {
        allCoords.add(pos);
        allCoords.add(pos + size - 1);
    }

    const sortedCoords = Array.from(allCoords).sort((a, b) => a - b);
    const coordMap = new Map();
    for (let i = 0; i < sortedCoords.length; i++) {
        coordMap.set(sortedCoords[i], i);
    }

    const N_COMPRESSED = sortedCoords.length;
    const tree = new Array(4 * N_COMPRESSED).fill(0);
    const lazy = new Array(4 * N_COMPRESSED).fill(0);

    function push(node) {
        if (lazy[node] !== 0) {
            tree[2 * node] = Math.max(tree[2 * node], lazy[node]);
            tree[2 * node + 1] = Math.max(tree[2 * node + 1], lazy[node]);

            lazy[2 * node] = Math.max(lazy[2 * node], lazy[node]);
            lazy[2 * node + 1] = Math.max(lazy[2 * node + 1], lazy[node]);

            lazy[node] = 0;
        }
    }

    function update(node, start, end, l, r, val) {
        if (start > end || start > r || end < l) {
            return;
        }

        if (l <= start && end <= r) {
            tree[node] = Math.max(tree[node], val);
            lazy[node] = Math.max(lazy[node], val);
            return;
        }

        push(node);

        const mid = Math.floor((start + end) / 2);
        update(2 * node, start, mid, l, r, val);
        update(2 * node + 1, mid + 1, end, l, r, val);

        tree[node] = Math.max(tree[2 * node], tree[2 * node + 1]);
    }

    function query(node, start, end, l, r) {
        if (start > end || start > r || end < l) {
            return 0;
        }

        if (l <= start && end <= r) {
            return tree[node];
        }

        push(node);

        const mid = Math.floor((start + end) / 2);
        const p1 = query(2 * node, start, mid, l, r);
        const p2 = query(2 * node + 1, mid + 1, end, l, r);

        return Math.max(p1, p2);
    }

    for (const [pos, size] of blocks) {
        const compressed_p = coordMap.get(pos);
        const compressed_p_plus_s_minus_1 = coordMap.get(pos + size - 1);
        update(1, 0, N_COMPRESSED - 1, compressed_p, compressed_p_plus_s_minus_1, pos + size - 1);
    }

    const ans = new Array(queries.length);
    for (let i = 0; i < queries.length; i++) {
        const [q_pos, q_size, q_id] = queries[i];
        const compressed_q_pos = coordMap.get(q_pos);
        const compressed_q_pos_plus_q_size_minus_1 = coordMap.get(q_pos + q_size - 1);

        const max_end_covered_in_query_range = query(1, 0, N_COMPRESSED - 1, compressed_q_pos, compressed_q_pos_plus_q_size_minus_1);

        if (max_end_covered_in_query_range < q_pos) {
            ans[q_id] = true;
            update(1, 0, N_COMPRESSED - 1, compressed_q_pos, compressed_q_pos_plus_q_size_minus_1, q_pos + q_size - 1);
        } else {
            ans[q_id] = false;
        }
    }

    return ans;
};