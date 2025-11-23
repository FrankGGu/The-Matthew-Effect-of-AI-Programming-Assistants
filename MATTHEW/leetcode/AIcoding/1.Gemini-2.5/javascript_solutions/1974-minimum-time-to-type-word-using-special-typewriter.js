var minTimeToType = function(word) {
    let totalTime = 0;
    let currentCharCode = 'a'.charCodeAt(0);

    for (let i = 0; i < word.length; i++) {
        const targetCharCode = word.charCodeAt(i);

        let diff = Math.abs(targetCharCode - currentCharCode);

        // Calculate the minimum distance on a circular keyboard
        const moveTime = Math.min(diff, 26 - diff);

        totalTime += moveTime; // Time to move cursor
        totalTime += 1;       // Time to type character

        currentCharCode = targetCharCode; // Update current cursor position
    }

    return totalTime;
};