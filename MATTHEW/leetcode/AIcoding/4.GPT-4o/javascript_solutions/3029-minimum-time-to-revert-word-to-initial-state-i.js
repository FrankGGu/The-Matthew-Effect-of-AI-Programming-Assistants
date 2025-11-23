function minimumTime(words) {
    let totalTime = 0;
    for (let word of words) {
        let time = 0;
        for (let char of word) {
            time += char.charCodeAt(0) - 'a'.charCodeAt(0) + 1;
        }
        totalTime += time;
    }
    return totalTime;
}