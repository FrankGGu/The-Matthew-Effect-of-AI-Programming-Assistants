var oddEvenJumps = function(A) {
    const n = A.length;
    if (n === 1) return 1;

    const odd = new Array(n).fill(false);
    const even = new Array(n).fill(false);
    odd[n - 1] = even[n - 1] = true;

    const oddJump = [];
    const evenJump = [];

    for (let i = 0; i < n; i++) {
        oddJump.push([A[i], i]);
        evenJump.push([A[i], i]);
    }

    oddJump.sort((a, b) => a[0] - b[0]);
    evenJump.sort((a, b) => a[0] - b[0]);

    for (let i = n - 1; i >= 0; i--) {
        const oddIndex = oddJump.findIndex(([_, idx]) => idx === i);
        const evenIndex = evenJump.findIndex(([_, idx]) => idx === i);

        if (oddIndex < oddJump.length - 1) {
            for (let j = oddIndex + 1; j < oddJump.length; j++) {
                if (oddJump[j][1] > i) {
                    odd[i] = even[oddJump[j][1]];
                    break;
                }
            }
        }

        if (evenIndex < evenJump.length - 1) {
            for (let j = evenIndex + 1; j < evenJump.length; j++) {
                if (evenJump[j][1] > i) {
                    even[i] = odd[evenJump[j][1]];
                    break;
                }
            }
        }
    }

    return odd.reduce((sum, canJump) => sum + (canJump ? 1 : 0), 0);
};