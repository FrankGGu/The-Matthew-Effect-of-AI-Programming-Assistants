var minPushes = function (targetWord) {
    const n = targetWord.length;
    let pushes = 0;

    for (let i = 0; i < n; i++) {
        const charCode = targetWord.charCodeAt(i) - 'a'.charCodeAt(0);
        pushes += Math.floor(charCode / 5) + 1;
    }

    return pushes;
};