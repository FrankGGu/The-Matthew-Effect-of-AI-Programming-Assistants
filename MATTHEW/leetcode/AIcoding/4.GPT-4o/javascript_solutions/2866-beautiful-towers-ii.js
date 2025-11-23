function beautifulTowers(n, k) {
    const towers = new Array(n).fill(0);
    let count = 0;

    function isBeautiful(tower) {
        const seen = new Set();
        for (let i = 0; i < tower.length; i++) {
            if (seen.has(tower[i])) return false;
            seen.add(tower[i]);
        }
        return seen.size === tower.length;
    }

    function buildTower(index) {
        if (index === n) {
            if (isBeautiful(towers)) count++;
            return;
        }
        for (let i = 1; i <= k; i++) {
            towers[index] = i;
            buildTower(index + 1);
        }
    }

    buildTower(0);
    return count;
}