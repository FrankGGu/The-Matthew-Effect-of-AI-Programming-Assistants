var maximizeSquareHoleArea = function(n, m, hBars, vBars) {
    function getMaxKSupported(removedBars, totalBarsCount) {
        const allBars = new Set(removedBars);
        allBars.add(0);
        allBars.add(totalBarsCount + 1);

        const sortedBars = Array.from(allBars).sort((a, b) => a - b);

        let maxConsecutiveAvailableLength = 0;

        for (let i = 0; i < sortedBars.length - 1; i++) {
            const currentConsecutiveLength = sortedBars[i+1] - sortedBars[i] - 1;
            maxConsecutiveAvailableLength = Math.max(maxConsecutiveAvailableLength, currentConsecutiveLength);
        }

        return Math.max(0, maxConsecutiveAvailableLength - 1);
    }

    const max_k_h = getMaxKSupported(hBars, n + 1);
    const max_k_v = getMaxKSupported(vBars, m + 1);

    const side = Math.min(max_k_h, max_k_v);

    return side * side;
};