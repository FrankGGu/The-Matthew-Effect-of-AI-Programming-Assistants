function maximumGain(num) {
    const s = num.toString();
    let max = 0;
    for (let i = 0; i < s.length; i++) {
        for (let j = i + 1; j < s.length; j++) {
            const newNum = parseInt(s.substring(0, i) + s.substring(i, j).split('').reverse().join('') + s.substring(j), 10);
            max = Math.max(max, newNum - num);
        }
    }
    return max;
}