var cycleLengthQueries = function(n, queries) {
    const result = [];
    for (const [node1, node2] of queries) {
        let len = 0;
        let a = node1;
        let b = node2;
        const pathA = [];
        const pathB = [];

        while (a > 0) {
            pathA.push(a);
            a = Math.floor(a / 2);
        }

        while (b > 0) {
            pathB.push(b);
            b = Math.floor(b / 2);
        }

        let i = pathA.length - 1;
        let j = pathB.length - 1;

        while (i >= 0 && j >= 0 && pathA[i] === pathB[j]) {
            i--;
            j--;
        }

        len += (pathA.length - 1 - i);
        len += (pathB.length - 1 - j);

        result.push(len);
    }
    return result;
};