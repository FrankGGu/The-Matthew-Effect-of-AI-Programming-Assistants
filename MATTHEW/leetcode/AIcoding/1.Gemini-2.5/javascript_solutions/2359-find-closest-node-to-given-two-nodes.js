var closestMeetingNode = function(edges, node1, node2) {
    const n = edges.length;
    const dist1 = new Array(n).fill(-1);
    const dist2 = new Array(n).fill(-1);

    function bfs(startNode, distArr) {
        const queue = [];
        queue.push([startNode, 0]);
        distArr[startNode] = 0;

        let head = 0;
        while(head < queue.length) {
            const [currNode, d] = queue[head++];
            const nextNode = edges[currNode];

            if (nextNode !== -1 && distArr[nextNode] === -1) {
                distArr[nextNode] = d + 1;
                queue.push([nextNode, d + 1]);
            }
        }
    }

    bfs(node1, dist1);
    bfs(node2, dist2);

    let minMaxDist = Infinity;
    let resultNode = -1;

    for (let i = 0; i < n; i++) {
        if (dist1[i] !== -1 && dist2[i] !== -1) {
            const currentMaxDist = Math.max(dist1[i], dist2[i]);
            if (currentMaxDist < minMaxDist) {
                minMaxDist = currentMaxDist;
                resultNode = i;
            }
            // If currentMaxDist === minMaxDist, we keep the existing resultNode
            // because we iterate from i=0 to n-1, ensuring the smallest index
            // is chosen first.
        }
    }

    return resultNode;
};