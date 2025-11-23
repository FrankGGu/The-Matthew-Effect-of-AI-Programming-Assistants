class TreeNode {
    constructor(val, left = null, right = null) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

var longestCommonSubpath = function(n, paths) {
    const MOD = 1e9 + 7;
    const BASE = 31;

    const getHash = (node, path) => {
        if (!node) return;
        path.push(node.val);
        getHash(node.left, path);
        getHash(node.right, path);
    };

    const hashPath = (path) => {
        let hash = 0;
        for (let i = 0; i < path.length; i++) {
            hash = (hash * BASE + path[i]) % MOD;
        }
        return hash;
    };

    const checkSubpath = (length) => {
        const seen = new Set();
        for (const path of paths) {
            const seenHashes = new Set();
            for (let i = 0; i <= path.length - length; i++) {
                const subPath = path.slice(i, i + length);
                seenHashes.add(hashPath(subPath));
            }
            for (let h of seenHashes) {
                if (seen.has(h)) return true;
                seen.add(h);
            }
        }
        return false;
    };

    let left = 1, right = Math.min(...paths.map(p => p.length)), ans = 0;
    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (checkSubpath(mid)) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return ans;
};