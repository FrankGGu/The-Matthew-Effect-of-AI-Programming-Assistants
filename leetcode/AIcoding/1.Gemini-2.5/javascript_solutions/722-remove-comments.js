var removeComments = function(source) {
    const result = [];
    let processedLineBuffer = "";
    let inBlockComment = false;

    for (const line of source) {
        for (let i = 0; i < line.length; i++) {
            if (inBlockComment) {
                if (i + 1 < line.length && line[i] === '*' && line[i+1] === '/') {
                    inBlockComment = false;
                    i++;
                }
            } else {
                if (i + 1 < line.length && line[i] === '/' && line[i+1] === '/') {
                    break;
                } else if (i + 1 < line.length && line[i] === '/' && line[i+1] === '*') {
                    inBlockComment = true;
                    i++;
                } else {
                    processedLineBuffer += line[i];
                }
            }
        }

        if (!inBlockComment && processedLineBuffer.length > 0) {
            result.push(processedLineBuffer);
            processedLineBuffer = "";
        }
    }

    return result;
};