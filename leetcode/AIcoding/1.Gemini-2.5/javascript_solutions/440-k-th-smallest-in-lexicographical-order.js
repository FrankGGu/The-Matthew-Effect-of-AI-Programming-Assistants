var findKthNumber = function(n, k) {
    let curr = 1;
    k--;

    function countNodes(n, curr) {
        let count = 0;
        let next = curr + 1;
        while (curr <= n) {
            count += Math.min(n + 1, next) - curr;
            curr *= 10;
            next *= 10;
        }
        return count;
    }

    while (k > 0) {
        const nodesInSubtree = countNodes(n, curr);

        if (k >= nodesInSubtree) {
            curr++;
            k -= nodesInSubtree;
        } else {
            curr *= 10;
            k--;
        }
    }

    return curr;
};