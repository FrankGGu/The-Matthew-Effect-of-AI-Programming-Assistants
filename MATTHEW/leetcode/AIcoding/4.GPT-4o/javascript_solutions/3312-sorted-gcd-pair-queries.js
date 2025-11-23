class Solution {
    gcd(a, b) {
        while (b) {
            [a, b] = [b, a % b];
        }
        return a;
    }

    gcdPairs(nums) {
        const n = nums.length;
        const gcds = new Array(n);
        for (let i = 0; i < n; i++) {
            for (let j = i; j < n; j++) {
                gcds.push(this.gcd(nums[i], nums[j]));
            }
        }
        return gcds.sort((a, b) => a - b);
    }

    gcdQuery(nums, queries) {
        const gcds = this.gcdPairs(nums);
        const result = [];
        for (const [l, r] of queries) {
            const g = gcds.slice(l - 1, r).sort((a, b) => a - b);
            result.push(g[g.length - 1]);
        }
        return result;
    }
}