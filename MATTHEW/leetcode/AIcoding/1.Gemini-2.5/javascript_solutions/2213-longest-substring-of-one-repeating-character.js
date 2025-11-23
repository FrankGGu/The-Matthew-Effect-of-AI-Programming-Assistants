class Node {
    constructor(len = 0, maxLen = 0, prefixChar = '', prefixLen = 0, suffixChar = '', suffixLen = 0) {
        this.len = len;
        this.maxLen = maxLen;
        this.prefixChar = prefixChar;
        this.prefixLen = prefixLen;
        this.suffixChar = suffixChar;
        this.suffixLen = suffixLen;
    }
}

let sArr;
let tree;
let N;

function merge(leftNode, rightNode) {
    const parent = new Node();
    parent.len = leftNode.len + rightNode.len;

    parent.prefixChar = leftNode.prefixChar;
    parent.prefixLen = leftNode.prefixLen;
    if (leftNode.prefixLen === leftNode.len && leftNode.prefixChar === rightNode.prefixChar) {
        parent.prefixLen += rightNode.prefixLen;
    }

    parent.suffixChar = rightNode.suffixChar;
    parent.suffixLen = rightNode.suffixLen;
    if (rightNode.suffixLen === rightNode.len && rightNode.suffixChar === leftNode.suffixChar) {
        parent.suffixLen += leftNode.suffixLen;
    }

    parent.maxLen = Math.max(leftNode.maxLen, rightNode.maxLen);
    if (leftNode.suffixChar === rightNode.prefixChar) {
        parent.maxLen = Math.max(parent.maxLen, leftNode.suffixLen + rightNode.prefixLen);
    }

    return parent;
}

function build(nodeIdx, start, end) {
    if (start === end) {
        const char = sArr[start];
        tree[nodeIdx] = new Node(1, 1, char, 1, char, 1);
        return;
    }

    const mid = Math.floor((start + end) / 2);
    build(2 * nodeIdx, start, mid);
    build(2 * nodeIdx + 1, mid + 1, end);
    tree[nodeIdx] = merge(tree[2 * nodeIdx], tree[2 * nodeIdx + 1]);
}

function update(nodeIdx, start, end, idx, char) {
    if (start === end) {
        sArr[idx] = char;
        tree[nodeIdx] = new Node(1, 1, char, 1, char, 1);
        return;
    }

    const mid = Math.floor((start + end) / 2);
    if (idx <= mid) {
        update(2 * nodeIdx, start, mid, idx, char);
    } else {
        update(2 * nodeIdx + 1, mid + 1, end, idx, char);
    }
    tree[nodeIdx] = merge(tree[2 * nodeIdx], tree[2 * nodeIdx + 1]);
}

var longestRepeatingSubstring = function(s, queryCharacters, queryIndices) {
    N = s.length;
    sArr = s.split('');

    tree = new Array(4 * N);

    if (N > 0) {
        build(1, 0, N - 1);
    } else {
        // Handle empty string case if N can be 0, though constraints say N >= 1
        // If N=0, tree[1] would be undefined, and maxLen would be 0
    }

    const results = [];
    for (let i = 0; i < queryCharacters.length; i++) {
        const idx = queryIndices[i];
        const char = queryCharacters[i];

        if (N > 0) {
            update(1, 0, N - 1, idx, char);
            results.push(tree[1].maxLen);
        } else {
            // If N=0, longest substring is 0
            results.push(0);
        }
    }

    return results;
};