var winnerOfGame = function(colors) {
    let alice = 0;
    let bob = 0;

    for (let i = 1; i < colors.length - 1; i++) {
        if (colors[i - 1] === 'A' && colors[i] === 'A' && colors[i + 1] === 'A') {
            alice++;
        } else if (colors[i - 1] === 'B' && colors[i] === 'B' && colors[i + 1] === 'B') {
            bob++;
        }
    }

    return alice > bob;
};