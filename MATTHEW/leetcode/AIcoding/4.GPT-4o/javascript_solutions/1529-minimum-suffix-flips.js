var minFlips = function(s) {
    const n = s.length;
    const doubleS = s + s;
    const target1 = '01'.repeat(n);
    const target2 = '10'.repeat(n);

    const getFlips = (target) => {
        let flips = 0;
        let minFlips = Infinity;
        for (let i = 0; i < doubleS.length; i++) {
            if (doubleS[i] !== target[i % n]) {
                flips++;
            }
            if (i >= n) {
                if (doubleS[i - n] !== target[(i - n) % n]) {
                    flips--;
                }
            }
            if (i >= n - 1) {
                minFlips = Math.min(minFlips, flips);
            }
        }
        return minFlips;
    };

    return Math.min(getFlips(target1), getFlips(target2));
};