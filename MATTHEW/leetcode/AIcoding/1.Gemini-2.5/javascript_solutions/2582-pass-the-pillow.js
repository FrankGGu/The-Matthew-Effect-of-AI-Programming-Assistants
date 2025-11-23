var passThePillow = function(n, time) {
    const cycleLength = (n - 1) * 2;
    const effectiveTime = time % cycleLength;

    if (effectiveTime < n - 1) {
        // Pillow is moving from left to right (1 to n)
        return 1 + effectiveTime;
    } else {
        // Pillow is moving from right to left (n to 1)
        const stepsBack = effectiveTime - (n - 1);
        return n - stepsBack;
    }
};