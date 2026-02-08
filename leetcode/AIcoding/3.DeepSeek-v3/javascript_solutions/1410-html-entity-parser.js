var entityParser = function(text) {
    const entityMap = {
        '&quot;': '"',
        '&apos;': "'",
        '&amp;': '&',
        '&gt;': '>',
        '&lt;': '<',
        '&frasl;': '/'
    };
    let result = '';
    let i = 0;
    while (i < text.length) {
        if (text[i] === '&') {
            let found = false;
            for (const entity in entityMap) {
                if (text.startsWith(entity, i)) {
                    result += entityMap[entity];
                    i += entity.length;
                    found = true;
                    break;
                }
            }
            if (!found) {
                result += text[i];
                i++;
            }
        } else {
            result += text[i];
            i++;
        }
    }
    return result;
};