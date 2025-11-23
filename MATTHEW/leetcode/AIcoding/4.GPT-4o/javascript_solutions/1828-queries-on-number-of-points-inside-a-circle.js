class Solution {
    countPoints(points, queries) {
        const result = [];
        for (const [xq, yq, rq] of queries) {
            let count = 0;
            for (const [xp, yp] of points) {
                if ((xp - xq) ** 2 + (yp - yq) ** 2 <= rq ** 2) {
                    count++;
                }
            }
            result.push(count);
        }
        return result;
    }
}