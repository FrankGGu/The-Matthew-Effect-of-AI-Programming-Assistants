function kthLargestPerfectSubtreeSize(root, k) {
    const perfectSizes = [];

    function isPerfect(node) {
        if (!node) return { depth: 0, perfect: true };

        const left = isPerfect(node.left);
        const right = isPerfect(node.right);

        const perfect = left.perfect && right.perfect && left.depth === right.depth;
        const depth = Math.max(left.depth, right.depth) + 1;

        if (perfect) {
            perfectSizes.push(depth);
        }

        return { depth, perfect };
    }

    isPerfect(root);

    perfectSizes.sort((a, b) => b - a);

    return perfectSizes.length >= k ? perfectSizes[k - 1] : -1;
}