class StringHasher {
    constructor(s, p, m) {
        this.p = p;
        this.m = m;
        this.n = s.length;
        this.prefixHashes = new Array(this.n + 1).fill(0);
        this.powers = new Array(this.n + 1).fill(1);

        for (let i = 0; i < this.n; i++) {
            this.prefixHashes[i + 1] = (this.prefixHashes[i] * this.p + (s.charCodeAt(i) - 96)) % this.m;
        }

        for (let i = 1; i <= this.n; i++) {
            this.powers[i] = (this.powers[i - 1] * this.p) % this.m;
        }
    }

    getHash(start, end) {
        if (start > end) return 0;
        let len = end - start + 1;
        let hash = (this.prefixHashes[end + 1] - (this.prefixHashes[start] * this.powers[len]) % this.m + this.m) % this.m;
        return hash;
    }
}

var largestMerge = function(word1, word2) {
    const n1 = word1.length;
    const n2 = word2.length;
    let i = 0;
    let j = 0;
    let merge = [];

    const p1 = 31, m1 = 1e9 + 7;
    const p2 = 37, m2 = 1e9 + 9;

    const hasher1_1 = new StringHasher(word1, p1, m1);
    const hasher1_2 = new StringHasher(word1, p2, m2);
    const hasher2_1 = new StringHasher(word2, p1, m1);
    const hasher2_2 = new StringHasher(word2, p2, m2);

    const compareSuffixes = (idx1, idx2) => {
        let low = 0, high = Math.min(n1 - idx1, n2 - idx2);
        let lcp = 0;

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (mid === 0) {
                lcp = Math.max(lcp, mid);
                low = mid + 1;
                continue;
            }

            const hash1_1 = hasher1_1.getHash(idx1, idx1 + mid - 1);
            const hash1_2 = hasher1_2.getHash(idx1, idx1 + mid - 1);
            const hash2_1 = hasher2_1.getHash(idx2, idx2 + mid - 1);
            const hash2_2 = hasher2_2.getHash(idx2, idx2 + mid - 1);

            if (hash1_1 === hash2_1 && hash1_2 === hash2_2) {
                lcp = Math.max(lcp, mid);
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        const char1_idx = idx1 + lcp;
        const char2_idx = idx2 + lcp;

        if (char1_idx < n1 && char2_idx < n2) {
            return word1[char1_idx] > word2[char2_idx];
        } else if (char1_idx < n1) {
            return true;
        } else {
            return false;
        }
    };

    while (i < n1 || j < n2) {
        if (i < n1 && (j === n2 || compareSuffixes(i, j))) {
            merge.push(word1[i]);
            i++;
        } else {
            merge.push(word2[j]);
            j++;
        }
    }

    return merge.join('');
};