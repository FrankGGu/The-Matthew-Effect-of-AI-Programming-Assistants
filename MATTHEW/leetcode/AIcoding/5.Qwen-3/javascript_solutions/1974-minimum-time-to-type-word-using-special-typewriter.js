var minTimeToType = function(word) {
    let time = 0;
    let prev = 0;
    for (let c of word) {
        let curr = c.charCodeAt(0) - 'a'.charCodeAt(0);
        time += Math.min(Math.abs(curr - prev), 26 - Math.abs(curr - prev));
        prev = curr;
    }
    return time;
};