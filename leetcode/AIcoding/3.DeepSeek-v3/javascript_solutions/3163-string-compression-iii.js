var compressedString = function(word) {
    let compressed = [];
    let i = 0;
    const n = word.length;

    while (i < n) {
        let currentChar = word[i];
        let count = 1;
        i++;

        while (i < n && word[i] === currentChar) {
            count++;
            i++;
        }

        compressed.push(currentChar);
        if (count > 1) {
            compressed.push(count.toString());
        }
    }

    return compressed.join('');
};