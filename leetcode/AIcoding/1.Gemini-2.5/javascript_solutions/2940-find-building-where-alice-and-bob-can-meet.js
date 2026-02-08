let heights_global;
let N_global;
let segmentTree_global;

function buildSegmentTree(node, start, end) {
    if (start === end) {
        segmentTree_global[node] = heights_global[start];
    } else {
        const mid = Math.floor((start + end) / 2);
        buildSegmentTree(2 * node, start, mid);
        buildSegmentTree(2 * node + 1, mid + 1, end);
        segmentTree_global[node] = Math.max(segmentTree_global[2 * node], segmentTree_global[2 * node + 1]);
    }
}

function querySegmentTree(node, start, end, query_L, query_R, target_height) {
    if (start > query_R || end < query_L) {
        return -1;
    }

    if (segmentTree_global[node] <= target_height) {
        return -1;
    }

    if (start === end) {
        return start;
    }

    const mid = Math.floor((start + end) / 2);

    const resultLeft = querySegmentTree(2 * node, start, mid, query_L, query_R, target_height);
    if (resultLeft !== -1) {
        return resultLeft;
    }

    const resultRight = querySegmentTree(2 * node + 1, mid + 1, end, query_L, query_R, target_height);
    return resultRight;
}

var findBuildings = function(heights, queries) {
    heights_global = heights;
    N_global = heights.length;
    segmentTree_global = new Array(4 * N_global);

    buildSegmentTree(1, 0, N_global - 1);

    const results = [];
    for (let i = 0; i < queries.length; i++) {
        const a = queries[i][0];
        const b = queries[i][1];

        const start_search_idx = Math.max(a, b);
        const required_min_height = Math.max(heights_global[a], heights_global[b]);

        const meetingPoint = querySegmentTree(1, 0, N_global - 1, start_search_idx, N_global - 1, required_min_height);
        results.push(meetingPoint);
    }

    return results;
};