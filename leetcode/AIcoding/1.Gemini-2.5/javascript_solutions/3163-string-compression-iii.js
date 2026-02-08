var compressString = function(word) {
    if (word.length === 0) {
        return "";
    }

    let compressed = [];
    let i = 0;

    while (i < word.length) {
        let char = word[i];
        let count = 0;
        let j = i;

        while (j < word.length && word[j] === char) {
            count++;
            j++;
        }

        if (count === 1) {
            compressed.push(char);
        } else if (count >= 2 && count <= 9) {
            compressed.push(char);
            compressed.push(count.toString());
        } else { // count >= 10
            while (count >= 10) {
                compressed.push(char);
                compressed.push('9');
                count -= 9;
            }
            if (count === 1) {
                compressed.push(char);
            } else if (count > 1) {
                compressed.push(char);
                compressed.push(count.toString());
            }
        }
        i = j;
    }

    return compressed.join('');
};