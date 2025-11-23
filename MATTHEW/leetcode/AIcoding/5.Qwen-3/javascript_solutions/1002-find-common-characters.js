function commonChars(words) {
    const count = new Array(26).fill(0);
    for (let i = 0; i < words[0].length; i++) {
        count[words[0].charCodeAt(i) - 97]++;
    }
    for (let i = 1; i < words.length; i++) {
        const temp = new Array(26).fill(0);
        for (let j = 0; j < words[i].length; j++) {
            temp[words[i].charCodeAt(j) - 97]++;
        }
        for (let k = 0; k < 26; k++) {
            count[k] = Math.min(count[k], temp[k]);
        }
    }
    const result = [];
    for (let i = 0; i < 26; i++) {
        while (count[i] > 0) {
            result.push(String.fromCharCode(i + 97));
            count[i]--;
        }
    }
    return result;
}