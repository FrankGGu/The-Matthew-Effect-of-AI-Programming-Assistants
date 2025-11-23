var minOperations = function(A, B) {
    const sumA = A.reduce((a, b) => a + b, 0);
    const sumB = B.reduce((a, b) => a + b, 0);

    if (sumA === sumB) return 0;

    let target = sumA - sumB;
    if (target < 0) {
        [A, B] = [B, A];
        target = -target;
    }

    const count = new Array(7).fill(0);
    for (const num of A) count[num]++;

    let operations = 0;
    for (let i = 6; i >= 1 && target > 0; i--) {
        while (count[i] > 0 && target > 0) {
            count[i]--;
            target -= i;
            operations++;
        }
    }

    return target > 0 ? -1 : operations;
};