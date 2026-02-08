var smallestMissingValueSubtree = function(parents, nums) {
    const N = parents.length;

    const adj = Array(N).fill(0).map(() => []);
    for (let i = 1; i < N; i++) {
        adj[parents[i]].push(i);
    }

    let node1Idx = -1;
    for (let i = 0; i < N; i++) {
        if (nums[i] === 1) {
            node1Idx = i;
            break;
        }
    }

    const ans = Array(N).fill(1);

    if (node1Idx === -1) {
        return ans;
    }

    let pathSet = new Set();
    let currentMissingVal = 1;

    const dfsCollectSideBranch = (u, p, collectedSet) => {
        collectedSet.add(nums[u]);
        for (const v of adj[u]) {
            if (v !== p) {
                dfsCollectSideBranch(v, u, collectedSet);
            }
        }
    };

    let curr = node1Idx;
    let prev = -1; 

    while (curr !== -1) {
        pathSet.add(nums[curr]);

        for (const v of adj[curr]) {
            if (v !== prev) {
                const sideBranchSet = new Set();
                dfsCollectSideBranch(v, curr, sideBranchSet);

                if (pathSet.size < sideBranchSet.size) {
                    const temp = pathSet;
                    pathSet = sideBranchSet;
                    sideBranchSet = temp;
                }
                for (const val of sideBranchSet) {
                    pathSet.add(val);
                }
            }
        }

        while (pathSet.has(currentMissingVal)) {
            currentMissingVal++;
        }
        ans[curr] = currentMissingVal;

        prev = curr;
        curr = parents[curr];
    }

    return ans;
};