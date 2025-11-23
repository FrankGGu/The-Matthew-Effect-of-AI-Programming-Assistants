var describePainting = function(painting) {
    let result = [];
    for (let i = 0; i < painting.length; i++) {
        let count = 1;
        while (i + 1 < painting.length && painting[i] === painting[i + 1]) {
            count++;
            i++;
        }
        result.push(count + painting[i]);
    }
    return result.join('');
};