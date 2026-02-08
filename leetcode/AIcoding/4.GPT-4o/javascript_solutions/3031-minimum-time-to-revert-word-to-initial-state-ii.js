function minimumTimeToChangeWords(words, time) {
    let totalTime = 0;
    for (let i = 0; i < words.length; i++) {
        totalTime += words[i].length * time;
    }
    return totalTime;
}