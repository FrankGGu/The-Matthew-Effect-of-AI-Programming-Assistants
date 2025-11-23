var longestRepeating = function(s, queryCharacters, queryIndices) {
    const n = s.length;
    const k = queryCharacters.length;
    const res = new Array(k);
    let sArr = s.split('');

    const SegmentTreeNode = function() {
        this.leftChar = '';
        this.rightChar = '';
        this.leftLen = 0;
        this.rightLen = 0;
        this.maxLen = 0;
        this.size = 0;
    };

    const merge = (left, right) => {
        const node = new SegmentTreeNode();
        node.leftChar = left.leftChar;
        node.rightChar = right.rightChar;
        node.size = left.size + right.size;

        node.leftLen = left.leftLen;
        if (left.leftLen === left.size && left.rightChar === right.leftChar) {
            node.leftLen += right.leftLen;
        }

        node.rightLen = right.rightLen;
        if (right.rightLen === right.size && left.rightChar === right.leftChar) {
            node.rightLen += left.rightLen;
        }

        node.maxLen = Math.max(left.maxLen, right.maxLen);
        if (left.rightChar === right.leftChar) {
            node.maxLen = Math.max(node.maxLen, left.rightLen + right.leftLen);
        }

        return node;
    };

    const build = (l, r) => {
        const node = new SegmentTreeNode();
        if (l === r) {
            node.leftChar = sArr[l];
            node.rightChar = sArr[l];
            node.leftLen = 1;
            node.rightLen = 1;
            node.maxLen = 1;
            node.size = 1;
            return node;
        }
        const mid = Math.floor((l + r) / 2);
        const left = build(l, mid);
        const right = build(mid + 1, r);
        return merge(left, right);
    };

    const update = (node, l, r, idx, char) => {
        if (l === r) {
            node.leftChar = char;
            node.rightChar = char;
            return;
        }
        const mid = Math.floor((l + r) / 2);
        if (idx <= mid) {
            update(node.left, l, mid, idx, char);
        } else {
            update(node.right, mid + 1, r, idx, char);
        }
        const merged = merge(node.left, node.right);
        node.leftChar = merged.leftChar;
        node.rightChar = merged.rightChar;
        node.leftLen = merged.leftLen;
        node.rightLen = merged.rightLen;
        node.maxLen = merged.maxLen;
    };

    let root = build(0, n - 1);

    for (let i = 0; i < k; i++) {
        const idx = queryIndices[i];
        const char = queryCharacters[i];
        if (sArr[idx] !== char) {
            sArr[idx] = char;
            update(root, 0, n - 1, idx, char);
        }
        res[i] = root.maxLen;
    }

    return res;
};