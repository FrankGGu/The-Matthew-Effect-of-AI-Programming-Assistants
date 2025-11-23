function findBuilding(n, lights) {
    const lighted = new Set(lights);
    let lastLight = -1;
    let minDistance = Infinity;
    let result = -1;

    for (let i = 1; i <= n; i++) {
        if (lighted.has(i)) {
            lastLight = i;
        }
        if (lastLight !== -1) {
            const distance = Math.abs(i - lastLight);
            if (distance < minDistance) {
                minDistance = distance;
                result = i;
            }
        }
    }

    lastLight = -1;
    for (let i = n; i >= 1; i--) {
        if (lighted.has(i)) {
            lastLight = i;
        }
        if (lastLight !== -1) {
            const distance = Math.abs(i - lastLight);
            if (distance < minDistance) {
                minDistance = distance;
                result = i;
            }
        }
    }

    return result;
}