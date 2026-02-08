var removeComments = function(source) {
    const result = [];
    let inBlock = false;
    for (const line of source) {
        let newLine = "";
        let i = 0;
        while (i < line.length) {
            if (inBlock) {
                if (i + 1 < line.length && line[i] === '*' && line[i + 1] === '/') {
                    inBlock = false;
                    i += 2;
                } else {
                    i++;
                }
            } else {
                if (i + 1 < line.length && line[i] === '/' && line[i + 1] === '*') {
                    inBlock = true;
                    i += 2;
                } else if (i + 1 < line.length && line[i] === '/' && line[i + 1] === '/') {
                    break;
                } else {
                    newLine += line[i];
                    i++;
                }
            }
        }
        if (!inBlock && newLine.length > 0) {
            result.push(newLine);
        }
    }
    return result;
};