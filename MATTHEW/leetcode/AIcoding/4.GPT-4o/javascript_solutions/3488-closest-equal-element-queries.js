class Solution {
    closestQueries(A, queries) {
        const n = A.length;
        const result = [];
        const positions = new Map();

        for (let i = 0; i < n; i++) {
            if (!positions.has(A[i])) positions.set(A[i], []);
            positions.get(A[i]).push(i);
        }

        for (const [x, y] of queries) {
            if (!positions.has(x)) {
                result.push(-1);
                continue;
            }
            const indices = positions.get(x);
            let left = 0, right = indices.length - 1;
            let closest = -1;

            while (left <= right) {
                const mid = Math.floor((left + right) / 2);
                if (indices[mid] >= y) {
                    closest = indices[mid];
                    right = mid - 1;
                } else {
                    left = mid + 1;
                }
            }
            result.push(closest);
        }

        return result;
    }
}