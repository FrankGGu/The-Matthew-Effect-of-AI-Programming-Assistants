var sortedGCDPairs = function(nums, queries) {
    const n = nums.length;
    const pairs = [];
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            pairs.push([nums[i], nums[j]]);
        }
    }

    pairs.sort((a, b) => {
        const gcdA = gcd(a[0], a[1]);
        const gcdB = gcd(b[0], b[1]);
        if (gcdA !== gcdB) {
            return gcdA - gcdB;
        }
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return a[1] - b[1];
    });

    const result = [];
    for (const query of queries) {
        let count = 0;
        for (const pair of pairs) {
            const gcdVal = gcd(pair[0], pair[1]);
            if (gcdVal >= query[0] && gcdVal <= query[1]) {
                count++;
            }
        }
        result.push(count);
    }

    return result;

    function gcd(a, b) {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    }
};