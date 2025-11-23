var canMouseWin = function(food, mouse, cat, width, height, catJump, mouseJump) {
    const MOUSE = 1;
    const CAT = 2;
    const DRAW = 0;

    const grid = Array(height).fill(null).map(() => Array(width).fill(0));
    const foodR = food[1];
    const foodC = food[0];
    const mouseR = mouse[1];
    const mouseC = mouse[0];
    const catR = cat[1];
    const catC = cat[0];

    const totalCells = width * height;

    function getResult(mouseR, mouseC, catR, catC, moves) {
        if (moves > 2 * totalCells) {
            return DRAW;
        }

        if (mouseR === catR && mouseC === catC) {
            return CAT;
        }

        if (mouseR === foodR && mouseC === foodC) {
            return MOUSE;
        }

        if (catR === foodR && catC === foodC) {
            return CAT;
        }

        if (memo[mouseR][mouseC][catR][catC][moves % 2] !== undefined) {
            return memo[mouseR][mouseC][catR][catC][moves % 2];
        }

        let result;
        if (moves % 2 === 0) {
            result = CAT;
            for (let i = 0; i <= mouseJump; i++) {
                let newMouseR = mouseR - i;
                if (newMouseR < 0) break;
                let res = getResult(newMouseR, mouseC, catR, catC, moves + 1);
                if (res === MOUSE) {
                    result = MOUSE;
                    break;
                }
            }
            if (result === CAT) {
                for (let i = 1; i <= mouseJump; i++) {
                    let newMouseR = mouseR + i;
                    if (newMouseR >= height) break;
                    let res = getResult(newMouseR, mouseC, catR, catC, moves + 1);
                    if (res === MOUSE) {
                        result = MOUSE;
                        break;
                    }
                }
            }
            if (result === CAT) {
                for (let i = 0; i <= mouseJump; i++) {
                    let newMouseC = mouseC - i;
                    if (newMouseC < 0) break;
                    let res = getResult(mouseR, newMouseC, catR, catC, moves + 1);
                    if (res === MOUSE) {
                        result = MOUSE;
                        break;
                    }
                }
            }
            if (result === CAT) {
                for (let i = 1; i <= mouseJump; i++) {
                    let newMouseC = mouseC + i;
                    if (newMouseC >= width) break;
                    let res = getResult(mouseR, newMouseC, catR, catC, moves + 1);
                    if (res === MOUSE) {
                        result = MOUSE;
                        break;
                    }
                }
            }
             if (result === CAT) {
                let res = getResult(mouseR, mouseC, catR, catC, moves + 1);
                 if (res === MOUSE) {
                        result = MOUSE;
                }
            }

        } else {
            result = MOUSE;
            for (let i = 0; i <= catJump; i++) {
                let newCatR = catR - i;
                if (newCatR < 0) break;
                let res = getResult(mouseR, mouseC, newCatR, catC, moves + 1);
                if (res === CAT) {
                    result = CAT;
                    break;
                }
            }
            if (result === MOUSE) {
                for (let i = 1; i <= catJump; i++) {
                    let newCatR = catR + i;
                    if (newCatR >= height) break;
                    let res = getResult(mouseR, mouseC, newCatR, catC, moves + 1);
                    if (res === CAT) {
                        result = CAT;
                        break;
                    }
                }
            }
            if (result === MOUSE) {
                for (let i = 0; i <= catJump; i++) {
                    let newCatC = catC - i;
                    if (newCatC < 0) break;
                    let res = getResult(mouseR, mouseC, catR, newCatC, moves + 1);
                    if (res === CAT) {
                        result = CAT;
                        break;
                    }
                }
            }
            if (result === MOUSE) {
                for (let i = 1; i <= catJump; i++) {
                    let newCatC = catC + i;
                    if (newCatC >= width) break;
                    let res = getResult(mouseR, mouseC, catR, newCatC, moves + 1);
                    if (res === CAT) {
                        result = CAT;
                        break;
                    }
                }
            }
             if (result === MOUSE) {
                let res = getResult(mouseR, mouseC, catR, catC, moves + 1);
                 if (res === CAT) {
                        result = CAT;
                }
            }
        }

        memo[mouseR][mouseC][catR][catC][moves % 2] = result;
        return result;
    }

    const memo = Array(height).fill(null).map(() =>
        Array(width).fill(null).map(() =>
            Array(height).fill(null).map(() =>
                Array(width).fill(null).map(() =>
                    Array(2).fill(undefined)
                )
            )
        )
    );

    return getResult(mouseR, mouseC, catR, catC, 0) === MOUSE;
};