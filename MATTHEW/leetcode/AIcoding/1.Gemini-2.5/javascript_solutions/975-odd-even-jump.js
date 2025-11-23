var oddEvenJumps = function(arr) {
    const n = arr.length;

    if (n <= 1) {
        return n;
    }

    function findNextGreaterEqual() {
        const nextGreaterEqual = new Array(n).fill(-1);
        const stack = [];

        const indexedArr = arr.map((val, idx) => [val, idx]);

        indexedArr.sort((a, b) => {
            if (a[0] !== b[0]) {
                return a[0] - b[0];
            }
            return a[1] - b[1];
        });

        for (const [val, idx] of indexedArr) {
            while (stack.length > 0 && stack[stack.length - 1] < idx) {
                nextGreaterEqual[stack.pop()] = idx;
            }
            stack.push(idx);
        }
        return nextGreaterEqual;
    }

    function findNextSmallerEqual() {
        const nextSmallerEqual = new Array(n).fill(-1);
        const stack = [];

        const indexedArr = arr.map((val, idx) => [val, idx]);

        indexedArr.sort((a, b) => {
            if (a[0] !== b[0]) {
                return b[0] - a[0];
            }
            return a[1] - b[1];
        });

        for (const [val, idx] of indexedArr) {
            while (stack.length > 0 && stack[stack.length - 1] < idx) {
                nextSmallerEqual[stack.pop()] = idx;
            }
            stack.push(idx);
        }
        return nextSmallerEqual;
    }

    const nextOddJump = findNextGreaterEqual();
    const nextEvenJump = findNextSmallerEqual();

    const dpOdd = new Array(n).fill(false);
    const dpEven = new Array(n).fill(false);

    dpOdd[n - 1] = true;
    dpEven[n - 1] = true;

    let goodStartingIndices = 1;

    for (let i = n - 2; i >= 0; i--) {
        if (nextOddJump[i] !== -1) {
            dpOdd[i] = dpEven[nextOddJump[i]];
        }

        if (nextEvenJump[i] !== -1) {
            dpEven[i] = dpOdd[nextEvenJump[i]];
        }

        if (dpOdd[i]) {
            goodStartingIndices++;
        }
    }

    return goodStartingIndices;
};