var removeComments = function(source) {
    let inBlock = false;
    let inLine = false;
    let result = [];
    let currentLine = '';

    for (let line of source) {
        for (let i = 0; i < line.length; i++) {
            if (inLine) {
                if (line[i] === '\n') {
                    inLine = false;
                    currentLine += line[i];
                }
            } else if (inBlock) {
                if (line[i] === '*' && i + 1 < line.length && line[i + 1] === '/') {
                    inBlock = false;
                    i++;
                }
            } else {
                if (line[i] === '/' && i + 1 < line.length && line[i + 1] === '/') {
                    inLine = true;
                    i++;
                    currentLine += line.slice(i) + '\n';
                    break;
                } else if (line[i] === '/' && i + 1 < line.length && line[i + 1] === '*') {
                    inBlock = true;
                    i++;
                } else {
                    currentLine += line[i];
                }
            }
        }
        if (!inLine && !inBlock && currentLine) {
            result.push(currentLine);
            currentLine = '';
        }
    }

    return result;
};