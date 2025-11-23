function minDominoRotationsForEqualRow(dominoes) {
    function check(c) {
        let rotations = 0;
        for (let i = 0; i < dominoes.length; i++) {
            if (dominoes[i][0] === c) {
                rotations++;
            } else if (dominoes[i][1] !== c) {
                return -1;
            }
        }
        return rotations;
    }

    let res = check(dominoes[0][0]);
    if (res === -1) {
        res = check(dominoes[0][1]);
    }
    return res;
}