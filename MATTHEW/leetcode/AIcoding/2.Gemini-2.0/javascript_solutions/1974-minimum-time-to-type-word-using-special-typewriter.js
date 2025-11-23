var minTimeToType = function(word) {
    let time = word.length;
    let current = 'a';
    for (let char of word) {
        let diff = Math.abs(char.charCodeAt(0) - current.charCodeAt(0));
        time += Math.min(diff, 26 - diff);
        current = char;
    }
    return time;
};