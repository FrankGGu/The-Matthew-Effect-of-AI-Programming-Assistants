var minTimeToType = function(word) {
    let time = word.length; 
    let prev = 'a'; 

    for (let char of word) {
        let diff = Math.abs(char.charCodeAt(0) - prev.charCodeAt(0));
        time += Math.min(diff, 26 - diff);
        prev = char;
    }

    return time;
};