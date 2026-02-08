var removeComments = function(source) {
    let inBlock = false;
    let newLine = [];
    let result = [];

    for (const line of source) {
        let i = 0;
        if (!inBlock) newLine = [];
        while (i < line.length) {
            if (!inBlock && i + 1 < line.length && line[i] === '/' && line[i + 1] === '*') {
                inBlock = true;
                i += 2;
            } else if (inBlock && i + 1 < line.length && line[i] === '*' && line[i + 1] === '/') {
                inBlock = false;
                i += 2;
            } else if (!inBlock && i + 1 < line.length && line[i] === '/' && line[i + 1] === '/') {
                break;
            } else if (!inBlock) {
                newLine.push(line[i]);
                i++;
            } else {
                i++;
            }
        }
        if (!inBlock && newLine.length > 0) {
            result.push(newLine.join(''));
        }
    }

    return result;
};