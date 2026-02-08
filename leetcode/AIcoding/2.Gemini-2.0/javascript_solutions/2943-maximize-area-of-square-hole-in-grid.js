var maximizeSquareHoleArea = function(n, m, hBars, vBars) {
    hBars.sort((a, b) => a - b);
    vBars.sort((a, b) => a - b);

    let maxH = 0;
    let currH = 1;
    for (let i = 1; i < hBars.length; i++) {
        if (hBars[i] === hBars[i - 1] + 1) {
            currH++;
        } else {
            maxH = Math.max(maxH, currH);
            currH = 1;
        }
    }
    maxH = Math.max(maxH, currH);

    let maxV = 0;
    let currV = 1;
    for (let i = 1; i < vBars.length; i++) {
        if (vBars[i] === vBars[i - 1] + 1) {
            currV++;
        } else {
            maxV = Math.max(maxV, currV);
            currV = 1;
        }
    }
    maxV = Math.max(maxV, currV);

    let side = Math.min(maxH + 1, maxV + 1);
    return side * side;
};