var flipLights = function(n, presses) {
    if (n === 0) return 0;
    if (presses === 0) return 1;
    if (n === 1) return presses > 0 ? 2 : 1;
    if (n === 2) return presses > 0 ? (presses === 1 ? 3 : 4) : 1;

    return presses > 0 ? (presses === 1 ? 4 : 4) : 1;
};