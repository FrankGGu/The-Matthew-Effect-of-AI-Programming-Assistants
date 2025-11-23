function minDamage(power, strength) {
    const n = power.length;
    const m = strength.length;
    const damage = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        let total = 0;
        for (let j = 0; j < m; j++) {
            if (power[i] === strength[j]) {
                total += Math.pow(2, j);
            }
        }
        damage[i] = total;
    }

    let result = 0;
    for (let i = 0; i < n; i++) {
        result += damage[i];
    }

    return result;
}