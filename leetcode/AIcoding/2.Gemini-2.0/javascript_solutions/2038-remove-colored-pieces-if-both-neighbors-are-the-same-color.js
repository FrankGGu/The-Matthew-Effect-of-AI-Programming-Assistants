var winnerOfGame = function(colors) {
    let a = 0;
    let b = 0;
    for (let i = 1; i < colors.length - 1; i++) {
        if (colors[i - 1] === colors[i] && colors[i] === colors[i + 1]) {
            if (colors[i] === 'A') {
                a++;
            } else {
                b++;
            }
        }
    }
    return a > b;
};