var minTimeToType = function(word) {
    let time = 0;
    let currentPos = 'a'.charCodeAt(0);
    for (let char of word) {
        let targetPos = char.charCodeAt(0);
        let diff = Math.abs(targetPos - currentPos);
        time += Math.min(diff, 26 - diff) + 1;
        currentPos = targetPos;
    }
    return time;
};