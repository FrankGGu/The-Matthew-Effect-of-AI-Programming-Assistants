var oddEvenJumps = function(arr) {
    const n = arr.length;
    if (n === 0) return 0;

    const odd = new Array(n).fill(false);
    const even = new Array(n).fill(false);
    odd[n - 1] = even[n - 1] = true;

    const map = new Map();
    map.set(arr[n - 1], n - 1);

    const sorted = [...arr].map((val, idx) => ({ val, idx })).sort((a, b) => a.val - b.val || a.idx - b.idx);
    const oddNext = new Array(n).fill(-1);
    const stack = [];

    for (const { val, idx } of sorted) {
        while (stack.length > 0 && stack[stack.length - 1] < idx) {
            oddNext[stack.pop()] = idx;
        }
        stack.push(idx);
    }

    const reverseSorted = [...arr].map((val, idx) => ({ val, idx })).sort((a, b) => b.val - a.val || a.idx - b.idx);
    const evenNext = new Array(n).fill(-1);
    stack.length = 0;

    for (const { val, idx } of reverseSorted) {
        while (stack.length > 0 && stack[stack.length - 1] < idx) {
            evenNext[stack.pop()] = idx;
        }
        stack.push(idx);
    }

    let res = 1;
    for (let i = n - 2; i >= 0; i--) {
        if (oddNext[i] !== -1) {
            odd[i] = even[oddNext[i]];
        }
        if (evenNext[i] !== -1) {
            even[i] = odd[evenNext[i]];
        }
        if (odd[i]) res++;
    }

    return res;
};