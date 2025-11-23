var numSquarefulPerms = function(A) {
    const count = new Array(100).fill(0);
    let result = 0;

    for (const num of A) {
        count[num]++;
    }

    const isSquareful = (a, b) => {
        const sum = a + b;
        const sqrt = Math.sqrt(sum);
        return sqrt * sqrt === sum;
    };

    const backtrack = (prev, used) => {
        if (used === A.length) {
            result++;
            return;
        }

        for (let i = 0; i < 100; i++) {
            if (count[i] > 0) {
                if (prev === -1 || isSquareful(prev, i)) {
                    count[i]--;
                    backtrack(i, used + 1);
                    count[i]++;
                }
            }
        }
    };

    backtrack(-1, 0);
    return result;
};