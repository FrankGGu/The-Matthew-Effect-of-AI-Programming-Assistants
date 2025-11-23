class SegTreeNode {

    constructor(start, end) {
        this.start = start;   // Start coordinate of this node's interval
        this.end = end;       // End coordinate of this node's interval
        this.left = null;     // Left child node, covering [start, mid]
        this.right = null;    // Right child node, covering [mid+1, end]
        this.count = 0;       // Number of active intervals that completely cover this node's range.
                              // Used for lazy propagation or determining if the range is fully colored.
        this.length = 0;      // Total length of colored segments within this node's range.
    }
}

class SegmentTree {

    constructor(minCoord, maxCoord) {
        // The root node covers the entire possible coordinate range.
        this.root = new SegTreeNode(minCoord, maxCoord);
    }

    update(node, queryStart, queryEnd, delta) {
        // If the current node's interval is completely outside the query range, do nothing.
        if (node.start > queryEnd || node.end < queryStart) {
            return;
        }

        // If the current node's interval is completely within the query range,
        // update its coverage count directly. This is a form of lazy propagation.
        if (queryStart <= node.start && node.end <= queryEnd) {
            node.count += delta;
        } else {
            // The query range partially overlaps with the current node's interval,
            // so we must recurse to its children.
            let mid = Math.floor((node.start + node.end) / 2);

            // Create children nodes if they don't exist yet (dynamic segment tree).
            if (!node.left) {
                node.left = new SegTreeNode(node.start, mid);
            }
            if (!node.right) {
                node.right = new SegTreeNode(mid + 1, node.end);
            }

            // Recursively update children nodes.
            this.update(node.left, queryStart, queryEnd, delta);
            this.update(node.right, queryStart, queryEnd, delta);
        }

        // After updating children or handling the base case, update the current node's total colored length.
        // If this node's interval is covered by at least one active interval (node.count > 0),
        // then its entire length is considered colored.
        if (node.count > 0) {
            node.length = node.end - node.start + 1; // Calculate inclusive length
        } else {
            // If this node's interval is not directly covered (node.count is 0),
            // its colored length is the sum of its children's colored lengths.
            // If children don't exist, their length is 0.
            node.length = (node.left ? node.left.length : 0) + (node.right ? node.right.length : 0);
        }
    }

    getTotalColoredLength() {
        return this.root.length;
    }
}

var BSTColoring = function() {
    // Initialize the segment tree. A common coordinate range for LeetCode problems
    // involving large coordinates is 1 to 10^9. Adjust if problem specifies otherwise.
    this.segmentTree = new SegmentTree(1, 10**9);
};

BSTColoring.prototype.addRange = function(start, end) {
    // Update the segment tree by incrementing the coverage count for the given range.
    this.segmentTree.update(this.segmentTree.root, start, end, 1);
    // Return the total colored length after the update.
    return this.segmentTree.getTotalColoredLength();
};

BSTColoring.prototype.removeRange = function(start, end) {
    // Update the segment tree by decrementing the coverage count for the given range.
    this.segmentTree.update(this.segmentTree.root, start, end, -1);
    // Return the total colored length after the update.
    return this.segmentTree.getTotalColoredLength();
};